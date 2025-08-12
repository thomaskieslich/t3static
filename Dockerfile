FROM php:8.3-cli

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    unzip \
    zip \
    ca-certificates \
    build-essential \
    git \
    libpng-dev \
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
ENV PATH="/usr/local/bin:${PATH}"

# Copy and install dependencies in the correct order
COPY . /app/t3static/

# Install dependencies with optimized flags
RUN cd /app/t3static && composer install --no-progress --no-ansi --no-interaction --prefer-dist --optimize-autoloader \
    && (npm ci --quiet --no-audit --no-fund 2>/dev/null || npm install --quiet --no-audit --no-fund) \
    && composer clear-cache

WORKDIR /app
