# How to settle in VirtualBox

* loadkeys fr
* check ip addressing : ip a
* fdisk /dev/sda
  * Use all disk
    * new partition: n
    * primary: p
    * all default
    * flag it bootable: a
* mkfs.ext4 -L nixos /dev/sda1
* mount /dev/disk/by-label/nixos /mnt
* nixos-generate-config --root /mnt

## If present, step over the fence
* export CURL_NIX_FLAGS="-x http://proxy.domain:port/"
* export http_proxy=http://proxy.domain:port/
* export https_proxy=http://proxy.domain:port/

## Bring your best pet
* nix-env -i git

## Pack up, move, unpack, decorate
* cd /mnt/etc/nixos
* git init
* git remote add origin https://github.com/bessonm/nixos-conf.git
* git fetch --all
* mv configuration.nix generated.conf.nix
* git checkout master
* Update configuration or create new machine if needed
* sudo ln ./machine/vm.nix machine.nix
* nixos-install
* reboot

Welcome home again :)


# Make room

* sudo nix-env -p /nix/var/nix/profiles/system --list-generations
* sudo bash -c "cd /boot/loader/entries; ls | grep -v GENERATION_NUMBER | xargs echo OR rm"
* nix-store --gc --print-roots | awk '{print $1}' | grep /result$ | sudo xargs echo OR rm
* sudo nix-collect-garbage -d
