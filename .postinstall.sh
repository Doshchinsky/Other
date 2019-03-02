#!/usr/bin/env bash

echo "Initializing post-install process..."
if [ -e /boot/vmlinuz-linux ]
then
  sudo mv /boot/vmlinuz-linux /boot/efi/EFI/Arch/vmlinuz-arch.efi
  sudo mkinitcpio -p linux
fi

if [ -e /boot/amd-ucode.img ]
then
  sudo mv /boot/amd-ucode.img /boot/efi/EFI/Arch/amd-ucode.img
fi
echo "Update complete!"
