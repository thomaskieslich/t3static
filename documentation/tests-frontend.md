# Frontend Tests

## Group Command

```bash
./t3static/t3static -t frontend
```

## Lint and Fix CSS and SCSS

Use [Stylelint](https://stylelint.io) with
[stylelint-config-standard-scss](https://github.com/stylelint/stylelint-config-standard).

[Configure Options](https://stylelint.io/user-guide/configure/)

## Local Configuration

Copy config to config-override and change Path Const in .en to
CONFIGURATION_PATH=config-override.
Config File for `./t3static/t3static -t css` is .csslintrc.json.
Config File for `./t3static/t3static -t scss` is .scsslintrc.json.

If you like to exclude Folders in Extension copy .stylelintignore.dist to Extension
Root as .stylelintignore and change for your needs.

### run Tests

```bash
ddev ssh
./t3static/t3static -t css
./t3static/t3static -t scss

# if fixable Errors try fix Version
./t3static/t3static -t css-fix
./t3static/t3static -t scss-fix

```

## Lint and Fix JavaScript

Use [Eslint](https://eslint.org) with [eslint-config-standard](https://github.com/standard/eslint-config-standard).

```bash
ddev ssh
./t3static/t3static -t js

# if fixable Errors try js-fix
./t3static/t3static -t js-fix

```
