# Frontend Tests

## Group Command

```bash
./tests/t3static/t3static.sh -t frontend
```

## Lint and Fix CSS and SCSS

Use [Stylelint](https://stylelint.io) with
[stylelint-config-standard-scss](https://github.com/stylelint/stylelint-config-standard).

[Configure Options](https://stylelint.io/user-guide/configure/)

## Local Configuration

Copy config to config-override and change Path Const in .en to
CONFIGURATION_PATH=config-override.
Config File for `./tests/t3static/t3static.sh -t css` is .csslintrc.json.
Config File for `./tests/t3static/t3static.sh -t scss` is .scsslintrc.json.

If you like to exclude Folders in Extension copy .stylelintignore.dist to Extension
Root as .stylelintignore and change for your needs.

### run Tests

```bash
ddev ssh
./tests/t3static/t3static.sh -t css
./tests/t3static/t3static.sh -t scss

# if fixable Errors try fix Version
./tests/t3static/t3static.sh -t css-fix
./tests/t3static/t3static.sh -t scss-fix

```

## Lint and Fix JavaScript

Use [Eslint](https://eslint.org) with [eslint-config-standard](https://github.com/standard/eslint-config-standard).

```bash
ddev ssh
./tests/t3static/t3static.sh -t js

# if fixable Errors try js-fix
./tests/t3static/t3static.sh -t js-fix

```
