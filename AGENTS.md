# AGENTS.md

Guidelines for agentic coding agents operating with t3static.

## Quick Reference

- Docker (recommended): `./t3static/run-docker -p <extension> -t <test>`
- Local fallback: `./t3static/run-local -p <extension> -t <test>`
- List tests: `./t3static/run-docker --list-tests`
- Rebuild: `./t3static/run-docker --rebuild`
- Test docs: `documentation/tests-*.md`

## Key Rules

- Always scope with `-p <extension>` — never run against the whole repo
- Always pass explicit `-t` — avoid interactive prompts
- Run lint first, then fix on request, then re-lint to verify
- Fix variants are named `<test>-fix` (e.g. `php-cs` → `php-cs-fix`)
- `--rebuild` deletes `vendor/` and `node_modules/` (destructive)

## .env Defaults

| Variable | Default | Note |
|----------|---------|------|
| `PACKAGE_PATH` | `packages` | Extension directories |
| `PHPSTAN_LEVEL` | `3` | PHPStan level (1-9) |
| `TYPO3SCAN_TARGET` | `13` | Deprecation scan target |
| `CONFIGURATION_PATH` | `config` | Use `config-override` for custom rules |

## Code Style

- PHP: TYPO3 coding standards (`typo3/coding-standards` + PHP-CS-Fixer)
- JS: ESLint standard config, single quotes, no trailing commas
- CSS/SCSS: Stylelint standard, 2-space indent, legacy color notation
- All: 2-space indent, Unix line endings, no trailing whitespace
