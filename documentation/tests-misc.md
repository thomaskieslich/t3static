# Misc File Tests

## Composer Validate

Validate composer.json (strict mode).
<https://getcomposer.org>

```bash
./t3static/run-docker -p <extension> -t composer-validate
```

## Composer Normalize

Normalize composer.json formatting with [ergebnis/composer-normalize](https://github.com/ergebnis/composer-normalize).

```bash
# check only
./t3static/run-docker -p <extension> -t composer-normalize

# fix
./t3static/run-docker -p <extension> -t composer-normalize-fix
```

## Json

Lint Json Files with [seld/jsonlint](https://github.com/Seldaek/jsonlint)

```bash
./t3static/run-docker -p <extension> -t json
```

## Markdown

Lint and Fix Markdown Files with [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)

```bash
# check only
./t3static/run-docker -p <extension> -t md

# fix
./t3static/run-docker -p <extension> -t md-fix
```

## Yaml

Lint Yaml Files with [symfony/yaml](https://symfony.com/doc/current/components/yaml.html)

```bash
./t3static/run-docker -p <extension> -t yaml
```
