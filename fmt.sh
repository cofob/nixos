#!/usr/bin/env bash
# nixfmt doesnt work properly with direnv. This scripts saves direnv folder to temporarty location before executing
# nixfmt, and then returns it back.

# Define the path to the .direnv directory
DIRENV_DIR=".direnv"

# Check if the .direnv directory exists
if [ -d "$DIRENV_DIR" ]; then
  # Define the temporary directory location
  TEMP_DIR=$(mktemp -d)

  # Move the .direnv directory to the temporary location
  echo "Moving $DIRENV_DIR to $TEMP_DIR..."
  mv "$DIRENV_DIR" "$TEMP_DIR"

  # Run nixfmt
  echo "Running nixfmt..."
  nixfmt .

  # Move the .direnv directory back from the temporary location
  echo "Moving $DIRENV_DIR back from $TEMP_DIR..."
  mv "$TEMP_DIR/$DIRENV_DIR" .

  # Remove the temporary directory if it's empty
  rmdir "$TEMP_DIR"
else
  # Run nixfmt if .direnv directory doesn't exist
  echo "No $DIRENV_DIR found. Running nixfmt..."
  nixfmt .
fi

echo "Operation completed."
