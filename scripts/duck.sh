#!/bin/sh

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Get the parent directory of the script
PARENT_DIR="$(dirname "$SCRIPT_DIR")"

# Load environment variables from the .env file in the parent directory
if [ -f "$PARENT_DIR/.env" ]; then
  # Use `export` to make variables available in the script's environment
  export $(grep -v '^#' "$PARENT_DIR/.env" | xargs)
else
  echo ".env file not found in the parent directory ($PARENT_DIR). Please ensure it exists."
  exit 1
fi

# Check if TOKEN is set
if [ -z "$DUCKDNS_TOKEN" ]; then
  echo "Error: DUCKDNS_TOKEN environment variable is not set. Evaluate the `.env` file."
  exit 1
fi

# Define the log directory (user-specific, following XDG spec)
LOG_DIR="$HOME/.local/share"

# Create the log directory (and any missing parent directories) if it doesn't exist
if [ ! -d "$LOG_DIR" ]; then
  mkdir -p "$LOG_DIR"
fi

# Construct the DuckDNS update URL
URL="https://www.duckdns.org/update?domains=$DUCKDNS_DOMAIN&token=$DUCKDNS_TOKEN&ip="

# Send the request and log the output
echo "url=\"$URL\"" | curl -k -o "$LOG_DIR/duck.log" -K -
