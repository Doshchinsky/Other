#!/usr/bin/env bash

echo -e "\n\e[1;33m==>\e[1;97m Initializing post-install process...\e[0;97m"
if [ -e /boot/vmlinuz-linux ]
then
  sudo mv /boot/vmlinuz-linux /boot/efi/EFI/Arch/vmlinuz-arch.efi
  sudo mkinitcpio -p linux
fi

if [ -e /boot/amd-ucode.img ]
then
  sudo mv /boot/amd-ucode.img /boot/efi/EFI/Arch/amd-ucode.img
fi
echo -e "\e[1;32mUpdate and post-install operations were successfully completed!\e[0;97m\n"
