# PHP Tests

## Group Command

```bash
ddev ssh
./tests/t3static/t3static.sh -t php
```

## php-cs-fixer

Check php code follow the Coding Guidelines.

Use [php-cs-fixer](https://github.com/PHP-CS-Fixer/PHP-CS-Fixer) for better Code Style.

Config from [TYPO3 Coding Standards](https://github.com/TYPO3/coding-standards)

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
