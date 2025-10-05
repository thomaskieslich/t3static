# t3static

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

## Configure

1. For default Settings just run t3static. If no .env found, the script create
   one if not exist
2. If you want to change configuration, copy t3static/.env.dist to
   t3static/.env and adopt the Settings/Paths to your Project.

## Run tests

Run test on a specific Package in your PACKAGE_PATH.

```bash
./t3static/run -p sitepackage
./t3static/run -p tea
```

### Run in a Docker Container

Run inside a docker container (recommended)
You can run the tools independently of your local php and node versions.
It builds the docker image once for use in all Projects.

```bash
./t3static/run
```

### Run in a local Environment

Your local Environment should have these versions:
php 8.4
node v22 - v24
composer 2
Test run quicker but not so stable

```bash
# on first run you must install composer and npm dependancies
./t3static/t3static -t install

# later
./t3static/t3static
```

## Structure

### ./t3static (Main Script)

- Load Environment Variables
- Install Script
- Load tests from includes Folder
- Define Test Options and Groups

Available groups (usage -t GROUP)

- frontend
- misc
- php
- typo3

For single tests have a look into the includes folder.
The files are based on the group names.

### configuration Folder

Here are the configuration files for the single tests from the includes folder.
If you want to override, make a copy like config-override and change the
CONFIGURATION_PATH in the .env file.

### results Folder

Here the results from some tests are written (php-stan,…)

## Usage

You can run test groups like:

```bash
./t3static/run -t frontend
./t3static/run -t misc
./t3static/run -t php
./t3static/run -t typo3
```

or single tests like (more tests defined in t3static):

```bash
./t3static/run -t css
# fix it
./t3static/run -t css-fix

./t3static/run -t rector
./t3static/run -t typo3scan
```

### Options

```text
choose test
-t ***testname***

set Extensionname (folder name)
-p ***extension
```

If you don’t define the test and the package as arguments or in the .env file,
a prompt will ask you what to update. You may omit neither, both, or just one of
the arguments. The priority order is:

1. CLI argument
2. .env file
3. Prompt

```bash
./t3static/run
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
