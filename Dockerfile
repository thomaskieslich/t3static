FROM php:8.4-cli

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    unzip \
    zip \
    ca-certificates \
    build-essential \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Configure PHP settings
RUN { \
      echo "max_execution_time=240"; \
      echo "max_input_time=240"; \
      echo "max_input_vars=1500"; \
      echo "memory_limit=1G"; \
    } > /usr/local/etc/php/conf.d/99-custom.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set PATH for Composer
ENV PATH="/root/.composer/vendor/bin:${PATH}"

# Copy and install dependencies in the correct order
WORKDIR /app-libs

# First copy only composer files to cache dependencies
COPY composer.json ./

# Install dependencies with optimized flags - make sure we install dev dependencies for tools
RUN composer install --no-progress --no-ansi --no-interaction --prefer-dist --optimize-autoloader \
    && composer clear-cache

# Copy other files and install npm dependencies  
COPY package.json ./
RUN (npm ci --quiet --no-audit --no-fund 2>/dev/null || npm install --quiet --no-audit --no-fund) \
    && npm cache clean --force

# Copy the startup script into the container
COPY start.sh /usr/local/bin/start.sh

# Make it executable
RUN chmod +x /usr/local/bin/start.sh

# Set the entrypoint to run the script
ENTRYPOINT ["/usr/local/bin/start.sh"]

# Set working directory to /app
WORKDIR /app
COPY composer.json package.json ./

# Install dependencies with optimized flags
RUN composer install --no-dev --no-progress --no-ansi --no-interaction --prefer-dist --optimize-autoloader \
    && (npm ci --quiet --no-audit --no-fund 2>/dev/null || npm install --quiet --no-audit --no-fund) \
    && composer clear-cache \
    && npm cache clean --force

# Copy the startup script into the container
COPY start.sh /usr/local/bin/start.sh

# Make it executable
RUN chmod +x /usr/local/bin/start.sh

# Set the entrypoint to run the script
ENTRYPOINT ["/usr/local/bin/start.sh"]

# Add a command to ensure proper execution
CMD ["/bin/bash"]


# Set working directory to /app
WORKDIR /app

