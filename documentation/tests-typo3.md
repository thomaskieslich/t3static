# TYPO3 Tests

## typoscript

Lint typoscript Files.

Tool: [helmich/typo3-typoscript-lint](https://github.com/martin-helmich/typo3-typoscript-lint)

```bash
./t3static/run-docker -p <extension> -t typoscript
```

## tsconfig

Lint tsconfig Files.

Tool: [helmich/typo3-typoscript-lint](https://github.com/martin-helmich/typo3-typoscript-lint)

```bash
./t3static/run-docker -p <extension> -t tsconfig
```

## Fractor

Upgrade and refactor TYPO3 code with fractor.

Tool: [a9f/typo3-fractor](https://github.com/andreaswolf/fractor-typo3-fractor)

```bash
# check only (dry-run)
./t3static/run-docker -p <extension> -t fractor

# apply fixes
./t3static/run-docker -p <extension> -t fractor-fix
```

## Rector

Upgrade and refactor php code.

Tool: [ssch/typo3-rector](https://github.com/sabbelasichon/typo3-rector)

<https://www.typo3-rector.com>

```bash
# check only (dry-run)
./t3static/run-docker -p <extension> -t rector

# apply fixes
./t3static/run-docker -p <extension> -t rector-fix
```

## TYPO3 Scanner

Scan TYPO3 Extension Files for deprecations and Errors like in BE.
The target version is configured via `TYPO3SCAN_TARGET` in `.env` (default: 13).

Tool: [michielroos/typo3scan](https://github.com/Tuurlijk/typo3scan-src)

```bash
./t3static/run-docker -p <extension> -t typo3scan
```
