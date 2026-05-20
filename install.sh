#!/bin/sh

DEVICE="$1"

# If no device was provided
if [ -z "$DEVICE" ]; then
    echo "No device specified."
    echo
    echo "Available block devices:"
    lsblk
    echo
    echo "Usage:"
    echo "  $0 /dev/sdX"
    echo "  $0 /dev/nvme0n1"
    exit 1
fi

echo "Using device: $DEVICE"
echo

echo "Remounting /nix/.rw-store..."
sudo mount -o remount,size=20G,noatime /nix/.rw-store

if [ $? -ne 0 ]; then
    echo "Failed to remount /nix/.rw-store"
    exit 1
fi

echo
echo "Running disko-install..."

sudo nix --extra-experimental-features "nix-command flakes" \
  run 'github:nix-community/disko/latest#disko-install' -- \
  --flake .#nixos \
  --disk main "$DEVICE"
