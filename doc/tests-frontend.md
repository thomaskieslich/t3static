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