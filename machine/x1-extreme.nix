{ config, pkgs, ... }:

let
  username = (import ../variables.nix).username;
in
{

  # Version
  system.stateVersion = "19.03";

  # Imports
  imports = [
    ../conf/de.openbox.nix
    ../conf/dev.common.nix
  ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = false;

  # Host
  networking.hostName = "nixos-x1";

  # Groups
  users.groups = {
    audio.members = [ "${username}" ];
  };

  # File System
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/9e46baae-0d6c-4776-894e-5da755a35ab8";
    fsType = "ext4";
  };

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/3474B00274AFC548";
    fsType = "ntfs";
  };

  ## Specific ##

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.earlyVconsoleSetup = true;

  powerManagement = {
    powertop.enable = true;
    cpuFreqGovernor = "powersave";
  };

  hardware.cpu.intel.updateMicrocode = true;

  networking.wireless.enable = false;
  networking.networkmanager.enable = true;

  # Override
  i18n.consoleFont = "latarcyrheb-sun32";
  fonts.fontconfig.dpi = 192;

  # Audio
  hardware.pulseaudio.enable = true;

  # Graphics
  hardware.bumblebee = {
    enable = true;
    driver = "nvidia";
    connectDisplay = true;
  };

  services = {

    xserver = {
      #videoDrivers = [ "modesetting" ];
      dpi = 192;
      monitorSection = ''
        DisplaySize 406 228
      '';
    };

    # Compositing
    compton = {
      backend = "glx";
      vSync = "opengl-swc";
      refreshRate = 0;
      extraOptions =
        ''
          # Tear-free configuration
          # @see https://github.com/chjj/compton/wiki/perf-guide
          # @see https://github.com/chjj/compton/wiki/vsync-guide
          glx-no-stencil = true;
          glx-copy-from-front = false;
          glx-swap-method = "undefined";
          paint-on-overlay = true;
          dbe = false;
        '';
    };

    # Screen
    redshift = {
      enable = true;
      latitude = "48.8502";
      longitude = "2.3488";
      brightness.day = "0.9";
      brightness.night = "0.7";
      temperature.day = 4600;
      temperature.night = 3500;
    };
  };

  nixpkgs.config.zathura.useMupdf = true;

  environment.variables = {

    # Fix sizes of GTK/GNOME ui elements
    GDK_SCALE = "2";
    GDK_DPI_SCALE= "0.5";

    # USB mounting support @see https://nixos.wiki/wiki/PCManFM
    GIO_EXTRA_MODULES = [ "${pkgs.gvfs}/lib/gio/modules" ];

  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    # Graphics
    bumblebee

    # Screen
    redshift

    # Media
    mpv
    mpvc

    # Reader
    calibre
    zathura

    # Torrent
    transmission-gtk

    # Virtualization
    virtualbox
  ];

}
