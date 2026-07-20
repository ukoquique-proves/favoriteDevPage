#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

# Load environment variables from .env file if it exists, but don't override existing ones
trim_value() {
    local value="$1"
    value="${value#"${value%%[![:space:]]*}"}"
    value="${value%"${value##*[![:space:]]}"}"
    printf '%s' "$value"
}

if [ -f .env ]; then
    echo "Loading environment variables from .env (without overriding existing ones)..."
    while IFS= read -r line || [ -n "$line" ]; do
        line="${line%$'\r'}"
        # Skip comments and empty lines
        if [[ "$line" =~ ^[[:space:]]*(#.*)?$ ]]; then
            continue
        fi
        # Parse KEY=VALUE while tolerating spaces around the separator and surrounding quotes
        if [[ "$line" =~ ^[[:space:]]*([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*=(.*)$ ]]; then
            key="${BASH_REMATCH[1]}"
            value="$(trim_value "${BASH_REMATCH[2]}")"
            if [[ "$value" =~ ^\"(.*)\"$ ]]; then
                value="${BASH_REMATCH[1]}"
            elif [[ "$value" =~ ^\'(.*)\'$ ]]; then
                value="${BASH_REMATCH[1]}"
            fi
            # Only set if not already set
            if [[ -z "${!key-}" ]]; then
                export "$key=$value"
            fi
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
