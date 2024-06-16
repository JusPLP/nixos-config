{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];



  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "max";



  networking.hostName = "jus";
  networking.networkmanager.enable = true; 



  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
	keyMap = "de";
  };



  services.xserver.enable = true;
  services.xserver.xkb.layout = "de";

  

  services.displayManager.sddm.wayland.enable = true;  
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;  



  environment.plasma6.excludePackages = with pkgs.kdePackages; [
	okular
	elisa
	oxygen
	khelpcenter
	plasma-browser-integration
  ];


 
  hardware.pulseaudio.enable = false;

  services.pipewire = {
	enable = true;
	pulse.enable = true;
  };



  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;  



  users.users.jus = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
	spotify
	chromium
	vesktop
	bitwarden-desktop
    ];
  };



  environment.systemPackages = with pkgs; [
	fastfetch
	fd
	eza

	# Driver
	mesa
  ];



  fonts.packages = with pkgs; [
	noto-fonts
	noto-fonts-emoji

	(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly"]; })
  ];



  nixpkgs.config = {
    chromium = {
	enableWideVine = true;	
    };
    allowUnfree = true;
  };



  system.stateVersion = "24.05"; # Dont change

}
