FROM php:8.3-cli

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

# Copy remaining files
COPY . /var/www/html/t3static

WORKDIR /var/www/html

RUN ./t3static/t3static.sh -t install

