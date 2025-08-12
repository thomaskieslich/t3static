#!/bin/bash
set -e

echo "DEBUG: start.sh executed at $(date)" >&2

# Check if /app-libs exists (it should be mounted from host)
if [ -d "/app-libs" ]; then
    echo "DEBUG: /app-libs directory found, creating symlinks" >&2

    # Create symbolic links if they don't exist or are invalid
    if [ ! -L "/app/t3static/node_modules" ] || [ ! -d "/app/t3static/node_modules" ]; then
        echo "DEBUG: Creating symlink for node_modules" >&2
        # Check if source directory exists before creating symlink
        if [ -d "/app-libs/node_modules" ]; then
            ln -sf /app-libs/node_modules /app/t3static/node_modules
        else
            echo "DEBUG: /app-libs/node_modules does not exist, skipping" >&2
        fi
    fi

    if [ ! -L "/app/t3static/vendor" ] || [ ! -d "/app/t3static/vendor" ]; then
        echo "DEBUG: Creating symlink for vendor" >&2
        # Check if source directory exists before creating symlink
        if [ -d "/app-libs/vendor" ]; then
            ln -sf /app-libs/vendor /app/t3static/vendor
        else
            echo "DEBUG: /app-libs/vendor does not exist, skipping" >&2
        fi
    fi

    echo "DEBUG: All symlinks created successfully" >&2
else
    echo "DEBUG: /app-libs directory not found, skipping symlink creation" >&2
fi

exec "$@"
