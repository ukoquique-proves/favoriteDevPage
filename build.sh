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

# Check if TOOLKIT_DOWNLOAD_URL is set
if [ -z "$TOOLKIT_DOWNLOAD_URL" ]; then
    echo "Error: TOOLKIT_DOWNLOAD_URL environment variable is not set."
    echo "Please set it in .env file or as an environment variable."
    exit 1
fi

# Check if template file exists
TEMPLATE_FILE="toolkit.html.template"
OUTPUT_FILE="toolkit.html"
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: Template file $TEMPLATE_FILE not found."
    exit 1
fi

# Replace placeholder with actual value and write output
echo "Building $OUTPUT_FILE with download URL: $TOOLKIT_DOWNLOAD_URL"
sed -e "s|{{TOOLKIT_DOWNLOAD_URL}}|$TOOLKIT_DOWNLOAD_URL|g" "$TEMPLATE_FILE" > "$OUTPUT_FILE"

echo "Build completed successfully!"
