FROM php:8.4-cli

# Create app user and group
RUN groupadd -r app && useradd -r -g app -m app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    unzip \
    zip \
    ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
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

# Copy t3static
COPY --chown=app:app . /app/t3static

# avoid local installed files
RUN rm -f composer.lock package-json.lock && rm -rf node_modules vendor

# Set working directory and user
WORKDIR /app/t3static
USER app

# Install PHP dependencies first (composer)
ENV COMPOSER_ROOT_VERSION=1.0.0
RUN composer install --no-progress --no-ansi --no-interaction --prefer-dist --optimize-autoloader --no-cache

# Install Node.js dependencies (npm)
RUN npm install --quiet --no-audit --no-fund && npm cache clean --force

# Final working dir
WORKDIR /app
