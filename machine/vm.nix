{ config, pkgs, ... }:

{

  imports = [
    ../conf/secrets.nix
    ../conf/de.openbox.nix
    ../conf/development.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.checkJournalingFS = false;

  networking.hostName = "nixos-vm";

  # Fix issue with RNG Daemon
  security.rngd.enable = false;

  fileSystems."/home/bessonm/shared" = {
    fsType = "vboxsf";
    device = "vbox_shared";
    mountPoint = "/home/bessonm/shared";
    noCheck = true;
    options = [ "defaults" ];
  };

  users.extraUsers.bessonm.extraGroups = [ "vboxsf" ];

}
