# nix-config/configuration.nix
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "Marvin";
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_GB.UTF-8";

  users.users.tdmunnik = {
    isNormalUser = true;
    description = "Thomas de Munnik";
    extraGroups = [ "wheel" "networkmanager" "bluetooth" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ffb57168-8310-455c-9094-c06829a95746";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/7B06-C2B4";
    fsType = "vfat";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.hyprland.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    hyprland
    kitty
    wl-clipboard
    blueman
    pipewire
    wofi
  ];

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  system.stateVersion = "24.11";
}
