{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];



  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.loader.systemd-boot.consoleMode = "max";



  networking.hostName = "jusplp";

  networking.networkmanager.enable = true; 



  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "de";
  };



  services.xserver.enable = true;
  
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;  


  # Configure keymap in X11
  services.xserver.xkb.layout = "de";


 
  # Enable sound.
  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };



  # fish shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;  



  # Don't forget to set a password with ‘passwd’.
  users.users.jus = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
	vesktop
	spotify
	chromium
    ];
  };



   environment.systemPackages = with pkgs; [
  	nano
	fastfetch
	fd
	eza
	gnome.gnome-tweaks
	htop
  	
	# Driver
	mesa
  ];

  fonts.packages = with pkgs; [
	noto-fonts
	noto-fonts-emoji
  
	(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly"]; })
  ];

  programs.steam = {
    enable = false;
  };

  nixpkgs.config = {
	allowUnfree = true;
  };



#  systemd.services.fixSuspendIssue = {
#    description = "Fix for the suspend issue";
#    after = [ "network.target" ];
#
#    serviceConfig = {
#      Type = "oneshot";
#      ExecStart = "/bin/sh -c 'echo GPP0 > /proc/acpi/wakeup'";
#      RemainAfterExit = true;
#    };
#
#    wantedBy = [ "multi-user.target" ];
#  };



  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;



  system.stateVersion = "24.05"; # Dont change

}

