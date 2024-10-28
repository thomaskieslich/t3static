# PHP Tests

## Group Command

```bash
ddev ssh
./tests/t3static/t3static.sh -t php
```

## php-cs-fixer

Check php code follow the Coding Guidelines.

Use [php-cs-fixer](https://github.com/PHP-CS-Fixer/PHP-CS-Fixer) for better Code
Style.

Config from https://git.typo3.org/typo3/typo3/-/tree/main/Build/php-cs-fixer

```bash
ddev ssh
./tests/t3static/t3static.sh -t php-cs

# if fixable Errors try fix Command
./tests/t3static/t3static.sh -t php-cs-fix

```

## phpstan
https://phpstan.org

```bash
ddev ssh
./tests/t3static/t3static.sh -t php-stan
```
