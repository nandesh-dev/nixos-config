#!/bin/bash

# Define screenshot directory
DIR="/home/$USER/Screenshots"

# Ensure directory exists
if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR"
    echo "Created directory: $DIR"
fi

# Check for --crop flag
if [ "$1" = "--crop" ]; then
    FILENAME="$DIR/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-selected.png"
    echo "Taking cropped screenshot: $FILENAME"
    maim --format=png --select "$FILENAME"
else
    FILENAME="$DIR/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-full.png"
    echo "Taking full screenshot: $FILENAME"
    maim --format=png "$FILENAME"
fi

# Copy to clipboard
xclip -selection clipboard -t image/png < "$FILENAME"
echo "Saved and copied to clipboard!"
