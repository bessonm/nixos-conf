{ config, pkgs, ... }:

let
  username = (import ../variables.nix).username;
in
{

  # Version
  system.stateVersion = "17.09";

  # Imports
  imports = [
    ../conf/de.console.nix
    ../conf/de.openbox.nix
    ../conf/dev.common.nix
    ../conf/music.nix
  ];

  # Boot
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    extraEntries = ''
      menuentry "Windows" {
        insmod part_gpt
        insmod fat
        insmod search_fs_uuid
        insmod chain
        search --fs-uuid --set=root 683E-24D4
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
    '';
    version = 2;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  # Host
  networking.hostName = "nixos";

  # Groups
  users.groups = {
    audio.members = [ "${username}" ];
  };

  # File System
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/555500a3-99c6-4d8c-8500-70a0e966987f";
    fsType = "ext4";
  };

 fileSystems."/mnt/other" = {
    device = "/dev/disk/by-uuid/564b621e-62de-4a43-acba-bc50b3a1650b";
    fsType = "ext4";
  };

 fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/60706E2E706E0ADC";
    fsType = "ntfs";
  };

  ## Specific ##

  hardware.cpu.intel.updateMicrocode = true;

  networking.wireless.enable = false;
  networking.networkmanager.enable = true;

  # Audio
  hardware.pulseaudio.enable = true;

  # Graphics
  hardware.bumblebee = {
    enable = true;
    driver = "nvidia";
    connectDisplay = true;
  };

  services = {
    
    # required for mounting android phones over mtp://
    gvfs.enable = true;
    
  };

  nixpkgs.config.zathura.useMupdf = true;

  # USB mounting support @see https://nixos.wiki/wiki/PCManFM
  environment.variables.GIO_EXTRA_MODULES = [ "${pkgs.gvfs}/lib/gio/modules" ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    # Graphics
    bumblebee

    # Media
    mpv

    # Reader
    zathura

    # Torrent
    transmission-gtk

  ];

}
