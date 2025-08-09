FROM php:8.4-cli

# System dependencies for Node.js + PHP Extensions
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    unzip \
    zip \
    ca-certificates \
    build-essential

# Node.js LTS (currently e.g. 20.x) from Nodesource
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs

# Increase PHP CLI limits
RUN { \
      echo "max_execution_time=240"; \
      echo "max_input_time=240"; \
      echo "max_input_vars=1500"; \
      echo "memory_limit=1G"; \
    } > /usr/local/etc/php/conf.d/99-custom.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Make Composer globally available and set PATH
ENV PATH="/root/.composer/vendor/bin:${PATH}"

# Copy only composer.json and package.json files
COPY composer.json package.json /tests/t3static/

# Install composer and npm
RUN cd /tests/t3static && composer install --no-dev --no-progress --no-ansi --no-interaction
RUN cd /tests/t3static && npm install --quiet

WORKDIR /tests

