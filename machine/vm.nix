{ config, pkgs, ... }:

{

  # Version
  system.stateVersion = "18.03";

  # Imports
  imports = [
    ./conf/secrets.nix
    ./conf/de.openbox.nix
    ./conf/development.nix
  ];

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.checkJournalingFS = false;

  # Host
  networking.hostName = "nixos-vm";

  # Groups
  users.groups = {
    vboxsf.members = [ "bessonm" ];
  };

  # File System
  fileSystems."/home/bessonm/shared" = {
    fsType = "vboxsf";
    device = "vbox_shared";
    mountPoint = "/home/bessonm/shared";
    noCheck = true;
    options = [ "defaults" ];
  };

  ## Specific ##

  security.rngd.enable = false; # Fix issue with RNG Daemon

  # Compositing
  services = {
    compton = {
      enable = true;
    };
  };

}
