{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];


  # Boot Configuration
  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "max";
    loader.timeout = 2;
  };


  # Zram Configuration
  zramSwap.enable = true;


  # Network Configuration
  networking = {
    hostName = "nixos";
    networkmanager.enable = true; 
  };


  # User Configuration
  users.users.jus = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };


  # Localization
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";


  # OpenGL Configuration
  hardware.graphics.enable = true;


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


  # Enable flatpak
  services.flatpak.enable = true;


  # System Packages
  environment.systemPackages = with pkgs; [
    gnome-tweaks    
    fastfetch
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


  # System Version
  system.stateVersion = "24.05";
}
