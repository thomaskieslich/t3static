# t3static

<span style="color:red;">!!!</span> Original Repository on: https://codeberg.org/kiesi/t3static <span style="color:red;">!!!</span>

Mirror only on Github: https://github.com/thomaskieslich/t3static

Collection of Tools to Test, Lint, Fix, and Upgrade multiple TYPO3 Extensions
in a Monorepo.
The rules are simple to bring the code in the individual extensions up to the
same level.

This is to have the most uniform code standards possible for projects with many
custom extensions. It can recognise and fix simple problems in the code. Use in
continuous integration pipelines is possible.
A special goal of this tool collection is to test TYPO3 extensions without great
effort and adjustments in the code.
This Tool has its own node_modules and vendor Settings and Folders.

## Install

### As Package to include to your project git

Download the package as zip to your project root and unzip.
Rename the Folder to t3static. You can move the folder to a subfolder like
tests/t3static, but then you must change the TEST_PATH in .env File.

### As separate git repo to get updates

1. Add this to your root .gitignore

    ```gitignore
    # t3static https://github.com/thomaskieslich/t3static
    /t3static
    ```

2. Clone the Repository

```bash
git clone git@github.com:thomaskieslich/t3static.git
```

## Prepare and Configure

You can just run `./t3static/run-docker` or `./t3static/run-local`.
If .env not exists a copy from .env.dist will be created. If used Tools
(composer, npm) not exist, they will be installed automatically.

If you want to change the configuration before the first run,
copy t3static/.env.dist

### Run tests in a Docker Container

Run inside a docker container (recommended).
So you can run the Tools independently of your local php and node versions.
It builds the docker image once for use in all Projects.

```bash
./t3static/run-docker
```

If Tools Versions are changed, you should rebuild the Docker Image with:

```bash
./t3static/run-docker --rebuild
```

You can also run for a specific extension:

```bash
./t3static/run-docker -p sitepackage -t php
```

### Run in a local Environment

Your local Environment should have these versions:
php 8.3 - 8.4
node v22 - v24
composer 2
Test run quicker, but not so stable.

```bash
./t3static/run-local
```

To rebuild tools, run:

```bash
./t3static/run-local --rebuild
```

## Structure

### ./t3static (Main Script)

- Load Environment Variables
- Install Script
- Load tests from the includes Folder

Available tests (use `--list-tests` to see all):

- css, css-fix, scss, scss-fix, js, js-fix
- php-cs, php-cs-fix, php-stan, php-stan-baseline
- fractor, fractor-fix, rector, rector-fix, typo3scan, typoscript, tsconfig
- composer-validate, composer-normalize, composer-normalize-fix, json, md, md-fix, yaml

### configuration Folder

Here are the configuration files for the single tests from the includes folder.
If you want to override, make a copy like config-override and change the
CONFIGURATION_PATH in the .env file.

### results Folder

Here the results from some tests are written (php-stan,…)

## Usage

You can run single tests like:

```bash
./t3static/run-docker -t css
# fix it
./t3static/run-docker -t css-fix

./t3static/run-docker -t rector
./t3static/run-docker -t typo3scan
```

or multiple, comma-separated tests like

```bash
./t3static/run-docker -t css,js

./t3static/run-docker -t fractor,rector
```

or for a specific extension:

```bash
./t3static/run-docker -p sitepackage -t php-cs
```

### Options

```text
choose test
-t ***testname***

set Extensionname (folder name)
-p ***extension***

rebuild tooling environment
--rebuild

list all available test types
--list-tests
```

Most tests have a fix variant named `<test>-fix` (e.g. `php-cs-fix`, `css-fix`, `js-fix`).
See the [Tests](#tests) section below for details.

If you don’t define the test and the package as arguments or in the .env file,
a prompt will ask you what to update. You may omit neither, both, or just one of
the arguments. The priority order is:

1. CLI argument
2. .env file
3. Prompt

```bash
./t3static/run-docker
```

```text
==> PACKAGE_NAME is empty.

==> Please choose a folder:

  1) package_1
  2) package_2
  3) sitepackage
Enter number (1-3):

==> TEST_TYPE is empty.

==> Please choose a test:

  1) all
  2) backend
  3) composer
  4) css
  ...
Enter number (1-x):
```

## Tests

[Frontend Tests](documentation/tests-frontend.md)

[Misc Tests](documentation/tests-misc.md)

[PHP Tests](documentation/tests-php.md)

[TYPO3 Tests](documentation/tests-typo3.md)

## ToDo

- Prettier for Styles and JavaScript
- linter for SQL
- Override Single Configurations
- add Tests to github actions
