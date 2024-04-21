# t3static
Collection of Tools to Test, Lint, Fix and Upgrade multiple TYPO3 Extensions in a Monorepo. The rules are simple to bring the code in the individual extensions up to the same level.

This is to have the most uniform code standards possible for projects with many local extensions. It should also be possible to recognise and fix simple problems in the code. Use in continuous integration pipelines should be possible.
A special goal of this tool collection is to test TYPO3 extensions without great effort and adjustments in the code.

## Install

Clone the Repository or download the Code iunto your project.

```bash
git clone git@github.com:thomaskieslich/t3static.git tests/t3static
```

## Default Settings
Copy .env.dist to .env and adopt the Settings to your Project.

```bash
# Settings
## Relative Path to this Code
TEST_PATH=tests/t3static

## Path to the Folder with Tool Configurations
CONFIGURATION_PATH=${TEST_PATH}/config

## Relative Path to the Extensions
PACKAGE_PATH=packages

## Default CLI Options
PACKAGE_DEFAULT=sitepackage
TEST_DEFAULT=frontend

## PHPSTAN LEVEL 1-9
PHPSTAN_LEVEL=3

## TYPO3 Version for Extension Scanner
TYPO3SCAN_TARGET=11
```

## Usage
### Options
```
choose test
-t ***testname***

set Extensionname (folder name)
-p ***extension
```

### Inside ddev
```
ddev ssh
./tests/t3static/t3static.sh -t php-stan
```

### ddev Command
Create a Command in .ddev/commands/web/[t3static](doc/t3static)
```
#!/bin/bash

## Description: Run t3static inside the web container
## Usage: t3static [flags] [args]
## Example: "ddev t3static -p news_extended -t php-cs"

./tests/t3static/t3static.sh "$@"
```

## Install Libraries
Install npm and composer Libraries.

```bash
ddev ssh
./tests/t3static/t3static.sh -t install
```

## Frontend Tests
[Frontend tests](doc/tests-frontend.md)

## ToDo
- Prettier for Styles and JavaScript
