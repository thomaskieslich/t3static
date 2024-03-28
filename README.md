# t3static
Collection of Tools to Test, Lint and Upgrade multiple TYPO3 Extensions.

## Install

```bash
git clone git@github.com:thomaskieslich/t3static.git tests/t3static
```

## Default Settings
Copy .env.dist to .env and change Settings.

## Frontend Tests

### SCSS

Use https://stylelint.io with stylelint-config-standard-scss.
Copy .stylelintrc.json.dist to your Scss Folder as .stylelintrc.json and adopt Paths.

```bash
ddev ssh
./tests/t3static/run.sh -t scss

# if fixable Errors try scss-fix
./tests/t3static/run.sh -t scss-fix

```

### JavaScript

Use https://eslint.org with eslint-config-standard.

```bash
ddev ssh
./tests/t3static/run.sh -t js

# if fixable Errors try js-fix
./tests/t3static/run.sh -t js-fix

```
