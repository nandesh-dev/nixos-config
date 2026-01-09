#!/usr/bin/env bash

# Polybar icons (T3 = font index for Nerd Font icons)
ACTIVE="%{T3}󱋖"
INACTIVE="%{T3}"
FAILED="%{T3}"

# Get systemd status
status=$(systemctl --user is-active nextcloud-sync 2>/dev/null)

case "$status" in
  inactive)
    echo "$INACTIVE"
    ;;
  failed)
    echo "$FAILED"
    ;;
  *)
    echo "$ACTIVE"
    ;;
esac
