# PHP Tests

## Group Command

```bash
ddev ssh
./t3static/t3static -t php
```

## php-cs-fixer

Check php code follow the Coding Guidelines.

Use [php-cs-fixer](https://github.com/PHP-CS-Fixer/PHP-CS-Fixer)
for better Code Style.

Config from [TYPO3 Coding Standards](https://github.com/TYPO3/coding-standards)

```bash
ddev ssh
./t3static/t3static -t php-cs

# if fixable Errors try fix Command
./t3static/t3static -t php-cs-fix

```

## phpstan

<https://phpstan.org>

```bash
ddev ssh
./t3static/t3static -t php-stan
```
