{ config, pkgs, ... }:

let
  username = (import ../variables.nix).username;
in
{

  # Version
  system.stateVersion = "19.03";

  # Imports
  imports = [
    ../conf/secrets.nix
    ../conf/de.openbox.nix
    ../conf/dev.common.nix
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
    vboxsf.members = [ "${username}" ];
  };

  ## Specific ##

  # Fix issue with RNG Daemon
  security.rngd.enable = false;

  environment.systemPackages = with pkgs; [

  ];

}
