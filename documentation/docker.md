# run with Docker

```
docker compose -f t3static/compose.yml build
docker compose -f t3static/compose.yml down
docker compose -f t3static/compose.yml run --rm t3static ./t3static/t3static.sh -t backend
docker compose -f t3static/compose.yml run --rm t3static pwd
docker compose -f t3static/compose.yml run --rm t3static ls -al t3static
docker compose -f t3static/compose.yml run --rm t3static id
docker compose -f t3static/compose.yml run --rm t3static php -v
docker compose -f t3static/compose.yml run --rm t3static node -v
docker compose -f t3static/compose.yml run --rm t3static composer about
```
