# Misc File Tests

## Group Command

```bash
ddev ssh
./tests/t3static/t3static.sh -t misc
```

## Composer

Simple Composer Validating. \
<https://getcomposer.org>

```bash
ddev ssh
./tests/t3static/t3static.sh -t composer
```

## Json

Lint Json Files with [seld/jsonlint](https://github.com/Seldaek/jsonlint)

```bash
ddev ssh
./tests/t3static/t3static.sh -t json
```

## Markdown

Lint and Fix Markdown Files with [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)

```bash
ddev ssh
./tests/t3static/t3static.sh -t md
```

## Yaml

Lint Yaml Files with [symfony/yaml](https://symfony.com/doc/current/components/yaml.html)

```bash
ddev ssh
./tests/t3static/t3static.sh -t yaml
```
