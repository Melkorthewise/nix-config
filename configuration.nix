# nix-config/configuration.nix
{ config, pkgs, zenBrowser, system, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_GB.UTF-8";

  users.users.tdmunnik = {
    isNormalUser = true;
    description = "Thomas de Munnik";
    extraGroups = [ "wheel" "networkmanager" "bluetooth" "docker" "dialout" ];
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

  programs.git.config = {
    init.defaultBranch = "main";
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    xkb = {
      layout = "us";
      options = "compose:lwin,caps:escape";
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
    unzip

    python3
    gcc
    cmake
    clang
    gdb
    ninja
    rustc
    cargo
    rust-analyzer
    clippy
    rustfmt
    go
    
    ripgrep
    lua-language-server
    nautilus
    arduino-cli
    arduino-ide

    zenBrowser.packages."${system}".default
  ];

  virtualisation.docker.enable = true;

  # services.displayManager.sddm.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "hyprland";

  networking.hostName = "Marvin";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 5173 ];
  };


  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  system.stateVersion = "24.11";
}
