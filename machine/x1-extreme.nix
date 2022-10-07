{ lib, config, pkgs, ... }:

let
  username = (import ../variables.nix).username;

  nvoffload = pkgs.writeShellScriptBin "nvoffload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{

  # Version
  system.stateVersion = "21.05";

  # Imports
  imports = [
    ../conf/de.console.nix
    ../conf/de.openbox.nix
    ../conf/dev.common.nix
  ];

  # Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    useOSProber = true;
    efiSupport = true;
    version = 2;
  };

  # Host
  networking = {
    hostName = "nixos-x1";
    useDHCP = false;
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp0s20f3.useDHCP = true;
  };

  # Groups
  users.groups = {
    audio.members = [ "${username}" ];
  };

  # File System

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/3474B00274AFC548";
    fsType = "ntfs";
  };

  fileSystems."/mnt/opt" = {
    device = "/dev/disk/by-uuid/9A6C61506C6127E9";
    fsType = "ntfs";
  };

  ## Specific ##

  hardware.cpu.intel.updateMicrocode = true;
  console.earlySetup = true;

  networking.wireless.enable = false;
  networking.networkmanager.enable = true;

  # Fix dual boot time
  time.hardwareClockInLocalTime = true;

  # Fix fan always on max
  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  # Audio
  hardware.pulseaudio.enable = true;

  # Graphics

  ## HiDPI
  hardware.video.hidpi.enable = lib.mkDefault true;
  console.font = "latarcyrheb-sun32";
  services.xserver.dpi = 110;
  services.xserver.monitorSection = ''
    DisplaySize 406 228
  '';

  environment.variables = {

    # HiDPI - Fix sizes of GTK/GNOME ui elements
    GDK_SCALE = "1";
    GDK_DPI_SCALE= "1";
    XCURSOR_SIZE = "32";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    # USB mounting support @see https://nixos.wiki/wiki/PCManFM
    GIO_EXTRA_MODULES = [ "${pkgs.gvfs}/lib/gio/modules" ];

  };

  # Run app using nvoffload
  boot.blacklistedKernelModules = [ "nouveau" ];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    # sync.enable = true;
    offload.enable = false;
    nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };
  hardware.nvidia.powerManagement.enable = false;

  # Boot with external display
  specialisation.nomad = {
      inheritParentConfig = true;
      configuration = {
        system.nixos.tags = [ "nomad" ];

        hardware.nvidia.prime.offload.enable = lib.mkForce true;
        hardware.nvidia.powerManagement.enable = lib.mkForce true;

        services.xserver.dpi = lib.mkForce 192;

        environment.variables.GDK_SCALE = lib.mkForce "2";
        environment.variables.GDK_DPI_SCALE = lib.mkForce "0.5";
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    # Graphics
    nvoffload
    vulkan-tools

    # Media
    mpv
    mpvc

    # Torrent
    transmission-gtk

    teams
    unstable.slack

  ];

}
