# TYPO3 Tests

## Group Command

```bash
ddev ssh
./t3static/t3static -t typo3
```

## typoscript

Lint typoscript Files.

Tool: [helmich/typo3-typoscript-lint](https://github.com/martin-helmich/typo3-typoscript-lint)

```bash
ddev ssh
./t3static/t3static -t typoscript
```

## tsconfig

Lint tsconfig Files.

Tool: [helmich/typo3-typoscript-lint](https://github.com/martin-helmich/typo3-typoscript-lint)

```bash
ddev ssh
./t3static/t3static -t tsconfig
```

## Fractor

Upgrade and refactor TYPO3 code with fractor.

Tool: [a9f/typo3-fractor](https://github.com/andreaswolf/fractor-typo3-fractor)

```bash
ddev ssh
./t3static/t3static -t fractor

./t3static/t3static -t fractor-fix
```

## Rector

Upgrade and refactor php code.

Tool: [ssch/typo3-rector](https://github.com/sabbelasichon/typo3-rector)

<https://www.typo3-rector.com>

```bash
ddev ssh
./t3static/t3static -t rector

./t3static/t3static -t rector-fix
```

## TYPO3 Scanner

Scan TYPO3 Extension Files for deprecations and Errors like in BE.

Tool: [michielroos/typo3scan](https://github.com/Tuurlijk/typo3scan-src)

```bash
ddev ssh
./t3static/t3static -t typo3scan
```
