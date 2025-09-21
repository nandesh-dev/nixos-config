FILENAME="/home/$USER/Screenshots/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-full.png"

maim --format=png "$FILENAME"
xclip -selection clipboard -t image/png < "$FILENAME"
