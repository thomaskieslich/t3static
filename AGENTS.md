# AGENTS.md

This file provides guidelines for agentic coding agents operating in this TYPO3 static analysis repository.

## Build/Lint/Test Commands

### General Commands
- `npm install` - Install all dependencies
- `./t3static/run-docker` - Run all tests in Docker container (recommended)
- `./t3static/run-local` - Run all tests locally
- `./t3static/run-docker --rebuild` - Rebuild Docker image with updated tools
- `./t3static/run-local --rebuild` - Rebuild local environment

### Running Single Tests
For single tests, use the run-docker or run-local scripts with specific test parameters:
- `./t3static/run-docker -t css` - Run CSS linting test
- `./t3static/run-docker -t js` - Run JavaScript linting test  
- `./t3static/run-docker -t php` - Run PHP linting test
- `./t3static/run-docker -t typo3scan` - Run TYPO3 scanner test
- `./t3static/run-docker -t rector` - Run Rector static analysis
- `./t3static/run-docker -t fractor` - Run Fractor refactoring tool
- `./t3static/run-docker -t composer-normalize` - Run Composer normalization check
- `./t3static/run-docker -t composer-normalize-fix` - Run Composer normalization with fixes
- `./t3static/run-local -t css` - Run CSS linting test locally
- `./t3static/run-local -t js` - Run JavaScript linting test locally
- `./t3static/run-local -t composer-normalize` - Run Composer normalization check locally
- `./t3static/run-local -t composer-normalize-fix` - Run Composer normalization with fixes locally

### Test Listing
- `./t3static/run-docker --list-tests` - List all available tests
- `./t3static/run-local --list-tests` - List all available tests

## Code Style Guidelines

### JavaScript/TypeScript
- Follow ESLint Standard style guide (extends eslint-config-standard)
- Use `standard` parser options with ES6 support
- Enforce strict mode in modules
- Use camelCase for variables and functions
- Use PascalCase for class names
- Use UPPER_CASE for constants
- Prefer single quotes for strings (unless escaping is required)
- No trailing commas in function parameters or array/object literals
- Use `const` for variables that won't be reassigned

### CSS/SCSS
- Follow Stylelint Standard configuration for SCSS
- Use stylelint-config-standard-scss as base config
- Allow legacy color function notation
- Disable selector class pattern validation by default
- Use 2-space indentation (no tabs)
- Unix line endings (\n)
- No trailing whitespace

### General JavaScript/TypeScript Guidelines
- Use camelCase for variables and functions
- Use PascalCase for class names
- Use UPPER_CASE for constants
- Prefer single quotes for strings (unless escaping is required)
- No trailing commas in function parameters or array/object literals
- Use `const` for variables that won't be reassigned

### Import/Export Style
- Group imports in order: external modules, internal modules, local files
- Sort imports alphabetically within each group
- Use relative paths for local imports (e.g., `./utils` or `../components`)
- Prefer named exports over default exports where possible

### Formatting
- 2-space indentation (no tabs)
- Unix line endings (\n)
- No trailing whitespace
- Single blank line between top-level code blocks

### Naming Conventions
- Variables and functions: camelCase (e.g., `isValid`, `processData`)
- Classes: PascalCase (e.g., `Component`, `Validator`)
- Constants: UPPER_CASE (e.g., `MAX_SIZE`, `API_URL`)
- Files: kebab-case (e.g., `data-handler.js`, `user-profile.ts`)

### Error Handling
- Use try/catch blocks for asynchronous operations where appropriate
- Handle errors gracefully without crashing the application
- Log errors with meaningful context information
- Prefer throwing custom error objects over generic Error instances

### TypeScript Guidelines (if applicable)
- Use strict type checking
- Prefer interfaces over types for object shapes
- Use readonly properties where appropriate
- Avoid using `any` type when possible
- Use union types for multiple valid states

## Configuration Files

### ESLint Configuration
Located at: `config/.eslintrc.json`
- Extends eslint-config-standard
- Enables browser and ES6 environments
- Uses module source type

### Stylelint Configuration
Located at: `config/.scsslintrc.json` and `config/.csslintrc.json`
- Extends stylelint-config-standard-scss for SCSS
- Extends stylelint-config-standard for CSS
- Allows legacy color function notation

## Available Test Groups and Types

### Test Groups:
- frontend (CSS, JS linting)
- misc (various linting tools)
- php (PHP linting and analysis)
- typo3 (TYPO3 specific tests)

### Individual Tests:
- css, js, php-cs, php-stan, typo3scan, rector, fractor, composer-validate, json, md, yaml, scss, etc.
- Use `--list-tests` flag to see all available tests

## Testing Approach
- All tests run in isolated environments (Docker or local)
- Tests are grouped by type for efficient execution
- Individual test runs are supported via command-line arguments
- Test scripts support both dry-run and fix modes where applicable
