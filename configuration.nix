{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];


  # systemd-boot Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "max";


  # Network Configuration
  networking.hostName = "jus";
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
  services.xserver.enable = false;
  services.xserver.xkb.layout = "de";
  
  services.displayManager.sddm.wayland.enable = true; # Experimental
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    okular
    elisa
    oxygen
    khelpcenter
    plasma-browser-integration
  ];


  # Audio Configuration
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };


  # Shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;  


  # Programs
  programs.steam.enable = false;


  # System Packages
  environment.systemPackages = with pkgs; [
    chromium
    spotify
    vesktop

    fastfetch
    fd
    eza

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
    chromium = {
      enableWideVine = true;
    };

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
