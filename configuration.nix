# nix-config/configuration.nix
{ config, pkgs, zenBrowser, system, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "Marvin";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_GB.UTF-8";

  users.users.tdmunnik = {
    isNormalUser = true;
    description = "Thomas de Munnik";
    extraGroups = [ "wheel" "networkmanager" "bluetooth" "docker" ];
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

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    xkb = {
      layout = "us";
      options = "compose:win,caps:escape";
    };
  };

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
    hyprpaper
    hyprlock
    playerctl
    docker
    docker-compose
    networkmanager
    gcc
    unzip
    python3
    ripgrep

    zenBrowser.packages."${system}".default
  ];

  virtualisation.docker.enable = true;

  # services.displayManager.sddm.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "hyprland";

  networking.firewall.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  system.stateVersion = "24.11";
}
