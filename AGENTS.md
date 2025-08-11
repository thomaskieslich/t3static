# AGENTS.md

## Build/Lint/Test Commands

### PHP Tests
- Run all PHP tests: `./t3static/t3static.sh -t php`
- Run single PHP test: `./t3static/t3static.sh -t php-stan` (or other specific test)
- Run PHP-CS-Fixer: `./vendor/bin/php-cs-fixer fix`
- Run PHPStan: `./vendor/bin/phpstan analyze`
- Run Rector: `./vendor/bin/rector process`

### Frontend Tests
- Run all frontend tests: `./t3static/t3static.sh -t frontend`
- Run CSS linting: `./t3static/t3static.sh -t css`
- Run CSS fixing: `./t3static/t3static.sh -t css-fix`

### Other Tests
- Run TYPO3 tests: `./t3static/t3static.sh -t typo3`
- Run misc tests: `./t3static/t3static.sh -t misc`

## Code Style Guidelines

### PHP
- Follow TYPO3 coding standards (PSR-12)
- Use php-cs-fixer for automatic formatting
- Use PHPStan for static analysis (level 4)
- Use Rector for code upgrades and refactoring
- All files must have proper PHPDoc blocks

### JavaScript/TypeScript
- Follow ESLint configuration in .eslintrc.json
- Use Prettier for code formatting (not currently included but planned)

### CSS/SCSS
- Follow Stylelint configuration in .scsslintrc.json
- Use standard CSS and SCSS linting rules

### General
- Use .editorconfig for consistent editor settings
- All code must follow TYPO3 conventions and best practices
- Use proper naming conventions (PascalCase for classes, camelCase for variables)
- All functions must have appropriate return types and parameter types
- Use proper error handling with try/catch blocks where needed

### Configuration Files
- PHP-CS-Fixer configuration: config/php-cs-fixer/coding-standards.php
- PHPStan configuration: config/php-stan/phpstan.neon
- Rector configuration: config/rector.php