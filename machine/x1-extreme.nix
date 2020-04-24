{ config, pkgs, ... }:

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
  system.stateVersion = "19.03";

  # Imports
  imports = [
    ../conf/de.console.nix
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

  hardware.cpu.intel.updateMicrocode = true;
  console.earlySetup = true;

  networking.wireless.enable = false;
  networking.networkmanager.enable = true;

  # Fix dual boot time
  time.hardwareClockInLocalTime = true;

  # Fix fan always on max
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  # Audio
  hardware.pulseaudio.enable = true;

  # Graphics

  ## HiDPI
  console.font = "latarcyrheb-sun32";
  fonts.fontconfig.dpi = 192;
  services.xserver.dpi = 192;
  services.xserver.monitorSection = ''
    DisplaySize 406 228
  '';

  # Run app using nvoffload
  boot.blacklistedKernelModules = [ "nouveau" ];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    # sync.enable = true;
    offload.enable = true;
    nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };

  environment.variables = {

    # HiDPI - Fix sizes of GTK/GNOME ui elements
    GDK_SCALE = "2";
    GDK_DPI_SCALE= "0.5";

    # USB mounting support @see https://nixos.wiki/wiki/PCManFM
    GIO_EXTRA_MODULES = [ "${pkgs.gvfs}/lib/gio/modules" ];

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

  ];

}
