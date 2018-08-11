# Nixos install in VirtualBox guest

* loadkeys fr
* check ip addressing : ip a
  * // TODO - In case of wifi need
* fdisk /dev/sda
  * Use all disk
    * new partition: n
    * primary: p
    * all default
    * flag it bootable: a
* mkfs.ext4 -L nixos /dev/sda1
* mount /dev/disk/by-label/nixos /mnt
* nixos-generate-config --root /mnt

## For connecting behind corporate proxy
* export CURL_NIX_FLAGS="-x http://proxy.domain:port/
* export http_proxy=http://proxy.domain:port/
* export https_proxy=http://proxy.domain:port/

## Install git
* nix-env -i git
* cd /mnt/etc/nixos
* git init
* git remote add origin https://github.com/bessonm/nixos-conf.git
* git fetch --all
* mv configuration.nix generated.conf.nix
* git checkout machine/vm
* diff configuration.nix generated.conf.nix
* Update configuration if needed
* nixos-install
* reboot

Welcome home again :)
