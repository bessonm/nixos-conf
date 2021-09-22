{ config, pkgs, ... }:

let
  username = (import ../variables.nix).username;
in
{

  # Version
  system.stateVersion = "20.09";

  # Imports
  imports = [
    ../conf/secrets.nix
    ../conf/de.vm.openbox.nix
    ../conf/dev.common.nix
  ];

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.checkJournalingFS = false;

  # Host
  networking.hostName = "nixos-vm";
  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;

  # Groups
  users.groups = {
    vboxsf.members = [ "${username}" ];
  };

  ## Specific ##

  # File System
  fileSystems."/windows" = {
    fsType = "vboxsf";
    device = "windows";
    options = [ "rw" "nofail" ];
  };

  environment.systemPackages = with pkgs; [

  ];

}
