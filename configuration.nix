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



  users.users.jus = {
	isNormalUser = true;
	extraGroups = [ "wheel" ];
  };



  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
	keyMap = "de";
  };



  services.xserver.enable = false;
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



  programs.steam.enable = false;



  environment.systemPackages = with pkgs; [
	chromium
	spotify

	fastfetch
	fd
	eza

	# Driver
	mesa
  ];



  fonts.packages = with pkgs; [
	noto-fonts
	noto-fonts-emoji
	noto-fonts-cjk

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
