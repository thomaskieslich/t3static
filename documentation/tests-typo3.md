# TYPO3 Tests

## Group Command

```bash
ddev ssh
./tests/t3static/t3static.sh -t typo3
```

## typoscript

Lint typoscript Files.

Tool: [helmich/typo3-typoscript-lint](https://github.com/martin-helmich/typo3-typoscript-lint)

```bash
ddev ssh
./tests/t3static/t3static.sh -t typoscript
```

## tsconfig

Lint tsconfig Files.

Tool: [helmich/typo3-typoscript-lint](https://github.com/martin-helmich/typo3-typoscript-lint)

```bash
ddev ssh
./tests/t3static/t3static.sh -t tsconfig
```

## Rector

Upgrade and refactor php code.

Tool: [ssch/typo3-rector](https://github.com/sabbelasichon/typo3-rector)

https://www.typo3-rector.com

```bash
ddev ssh
./tests/t3static/t3static.sh -t rector

./tests/t3static/t3static.sh -t rector-fix
```

## TYPO3 Scanner

Scan TYPO3 Extension Files for deprecations and Errors like in BE.

Tool: [michielroos/typo3scan](https://github.com/Tuurlijk/typo3scan-src)

```bash
ddev ssh
./tests/t3static/t3static.sh -t typo3scan
```
