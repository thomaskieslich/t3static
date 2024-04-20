# PHP Tests

## php-cs-fixer

Use [php-cs-fixer](https://github.com/PHP-CS-Fixer/PHP-CS-Fixer) for better Code Style.

Config from https://git.typo3.org/typo3/typo3/-/tree/main/Build/php-cs-fixer

```bash
ddev ssh
./tests/t3static/t3static.sh -t php-cs

# if fixable Errors try fix Version
./tests/t3static/t3static.sh -t php-cs-fix

```
