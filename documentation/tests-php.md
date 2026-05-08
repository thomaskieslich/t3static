# PHP Tests

## php-cs-fixer

Check php code follows the Coding Guidelines.

Use [php-cs-fixer](https://github.com/PHP-CS-Fixer/PHP-CS-Fixer)
for better Code Style.

Config from [TYPO3 Coding Standards](https://github.com/TYPO3/coding-standards)

```bash
# check only
./t3static/run-docker -p <extension> -t php-cs

# fix
./t3static/run-docker -p <extension> -t php-cs-fix

```

## phpstan

Static analysis with [PHPStan](https://phpstan.org).
The level is configured via `PHPSTAN_LEVEL` in `.env` (default: 3).

```bash
./t3static/run-docker -p <extension> -t php-stan
```

## phpstan-baseline

Generate a PHPStan baseline file to ignore existing errors.
The baseline is written to `t3static/results/phpstan-<extension>-errors.neon`.

```bash
./t3static/run-docker -p <extension> -t php-stan-baseline
```
