FILENAME="/home/$USER/Screenshots/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-selected.png"

maim --format=png --select "$FILENAME"
xclip -selection clipboard -t image/png < "$FILENAME"
