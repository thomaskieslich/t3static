# t3static
Collection of Tools to Test, Lint and Upgrade multiple TYPO3 Extensions.

## Install

```bash
git clone git@github.com:thomaskieslich/t3static.git tests/t3static
```

## Default Settings
Copy .env.dist to .env and change Settings.

## Init Libraries
Install npm and composer Libraries.

```bash
ddev ssh
./tests/t3static/t3static.sh -t init
```

## Frontend Tests

### SCSS

Use https://stylelint.io with stylelint-config-standard-scss.
Configure Options: https://stylelint.io/user-guide/configure/
Copy .stylelintrc.json.dist to your Scss Folder as .stylelintrc.json and adopt Paths.

```bash
ddev ssh
./tests/t3static/t3static.sh -t scss

# if fixable Errors try scss-fix
./tests/t3static/t3static.sh -t scss-fix

```

### JavaScript

Use https://eslint.org with eslint-config-standard.

```bash
ddev ssh
./tests/t3static/t3static.sh -t js

# if fixable Errors try js-fix
./tests/t3static/t3static.sh -t js-fix

```
