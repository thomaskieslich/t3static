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
```

2. Clone the Repository or download the Code into your project.

```bash
git clone git@github.com:thomaskieslich/t3static.git tests/t3static
```

3. change Default Settings
Copy t3static/.env.dist to t3static/.env and adopt the Settings/Paths to your Project.

4. if you use ddev, copy t3static/documentation/t3static to .ddev/commands/web/t3static

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

### configuration Folder
Here are the Configuration Files the Single Test from includes folder.
If you want to Override, make a copy like config-override and change
the CONFIGURATION_PATH in the .env File.

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
