{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];


  # systemd-boot Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "max";


  # Zram configuration
  zramSwap.enable


  # Network Configuration
  networking.hostName = "nixos";
  networking.networkmanager.enable = true; 


  # User Configuration
  users.users.jus = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };


  # Localization
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";


  # System Version
  system.stateVersion = "24.05";


  # X-Server and Desktop Configuration
  services.xserver = {
    enable = true;
    xkb.layout = "de";

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };


  # Audio Configuration
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };


  # System Packages
  environment.systemPackages = with pkgs; [
    fastfetch

    # Driver
    mesa
  ];


  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly"]; })
  ];


  # Nixpkgs Configuration
  nixpkgs.config = {
    allowUnfree = true;
  };


  # Fix Suspend
  systemd.services.fixSuspendIssue = {
    description = "Fix for the suspend issue";
    after = [ "network.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/bin/sh -c 'echo GPP0 > /proc/acpi/wakeup'";
      RemainAfterExit = true;
    };

    wantedBy = [ "multi-user.target" ];
  };
}
