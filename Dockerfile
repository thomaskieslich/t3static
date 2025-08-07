FROM php:8.4-cli

# System-Abhängigkeiten für Node.js + PHP Extensions
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    unzip \
    zip \
    ca-certificates \
    build-essential

# Node.js LTS (aktuell z.B. 20.x) von Nodesource
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs

# Composer installieren
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Composer global verfügbar machen und Pfad setzen
ENV PATH="/root/.composer/vendor/bin:${PATH}"

# Rest der Dateien kopieren
COPY . /var/www/html/t3static

WORKDIR /var/www/html

RUN ./t3static/t3static.sh -t install

