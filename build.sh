#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

# Load environment variables from .env file if it exists, but don't override existing ones
if [ -f .env ]; then
    echo "Loading environment variables from .env (without overriding existing ones)..."
    while IFS= read -r line; do
        # Skip comments and empty lines
        if [[ "$line" =~ ^#.*$ ]] || [[ -z "$line" ]]; then
            continue
        fi
        # Split into key and value
        key=$(echo "$line" | cut -d= -f1)
        value=$(echo "$line" | cut -d= -f2-)
        # Only set if not already set
        if [[ -z "${!key}" ]]; then
            export "$key"="$value"
        fi
    done < .env
fi

# Run the python build script to assemble templates and inject partials
if command -v python3 >/dev/null 2>&1; then
    echo "Running Python static site generator..."
    python3 tools/build.py
    if [ $? -ne 0 ]; then
        echo "Error: Python build script failed."
        exit 1
    fi
else
    echo "Error: python3 is required to build the templates."
    exit 1
fi

echo "Build completed successfully!"
