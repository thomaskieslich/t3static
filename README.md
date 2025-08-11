# t3static
Collection of Tools to Test, Lint, Fix and Upgrade multiple TYPO3 Extensions in a Monorepo.
The rules are simple to bring the code in the individual extensions up to the same level.

This is to have the most uniform code standards possible for projects with many custom extensions.
It should also be possible to recognise and fix simple problems in the code.
Use in continuous integration pipelines should be possible.
A special goal of this tool collection is to test TYPO3 extensions without great effort and adjustments in the code.
This Tool have its own node_modules and vendor Settings and Folders.

## Install

1. Add this to your root .gitignore
```
# t3static https://github.com/thomaskieslich/t3static
/t3static
/.ddev/commands/web/t3static
/.php_cs.cache
```

2. Clone the Repository or download the Code into your project.

```bash
git clone git@github.com:thomaskieslich/t3static.git
```

3. if you want to use default Settings, copy t3static/.env.dist to t3static/.env and adopt the Settings/Paths to your Project.
```bash
cp t3static/.env.dist t3static/.env
```

4. if you use ddev, copy t3static/documentation/t3static to .ddev/commands/web/t3static
```bash
cp t3static/documentation/t3static .ddev/commands/web/t3static
```

5. Install Packages
```bash
ddev ssh
./t3static/t3static.sh -t install
```

## Structure
### ./t3static.sh (Main Script)
- Load Environment Variables
- Install Script
- Load tests from includes Folder
- Define Test Options and Groups

Available groups (usage -t GROUP)
- frontend
- misc
- php
- typo3

For Single tests have a Look into the includes Folder.
The files based on the Group Names.

### Configurations

All tests have a default configuration located in the config/ folder.  

You can override these configuration files or use your own by creating a custom configuration folder and specifying its path in the .env file under CONFIGURATION_PATH.  

You only need to place those files in the config-override folder that you actually want to override.
If a configuration file is not present in config-override, the default configuration from the config folder will be used instead.

default-path: config/  
.env: CONFIGURATION_PATH

### results Folder
Here the results from some Tests written (php-stan,…)

## Usage
You can run test Groups like:
```
ddev t3static -t frontend
ddev t3static -t misc
ddev t3static -t php
ddev t3static -t typo3
```

or Single tests like (more test defined in t3static.sh:
```
ddev t3static -t css
# fix it
ddev t3static -t css-fix

ddev t3static -t rector
ddev t3static -t typo3scan
```

### Options
```
choose test
-t ***testname***

set Extensionname (folder name)
-p ***extension
```

If you don’t define the test and the package as arguments or in the .env file, a prompt will ask you what to update.  
You may omit neither, both, or just one of the arguments. The priority order is:
1. CLI argument
2. .env file
3. Prompt

```bash
ddev t3static
```

```bash
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

### Run t3static
```
# inside ddev
ddev ssh
./t3static/t3static.sh -t php-stan

# ddev command
ddev t3static ./t3static/t3static.sh -t php-stan
```

## Tests
[Frontend Tests](documentation/tests-frontend.md)

[Misc Tests](documentation/tests-misc.md)

[PHP Tests](documentation/tests-php.md)

[TYPO3 Tests](documentation/tests-typo3.md)

## ToDo
- Prettier for Styles and JavaScript
