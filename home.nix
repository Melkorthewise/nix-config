# nix-config/home.nix
{ config, pkgs, ... }:

{
  imports = [
    ./modules/waybar/waybar.nix
  ];

  home.username = "tdmunnik";
  home.homeDirectory = "/home/tdmunnik";

  programs.zsh.enable = true;
  programs.git = {
    enable = true;

    userName = "Melkorthewise";
    userEmail = "thomasdemunnik05@gmail.com";
  };
  
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./modules/hypr/hyprland.conf;
  };

  programs = {
    # dunst.enable = true;

    kitty = {
      enable = true;
      # Optional: configFile = ./kitty.conf;
    };

    # wlClipboard.enable = true;
  };

  programs.wofi = {
    enable = true;
    settings = {
      location = "center";
      allow_markup = true;
      show = "drun";
      allow_images = true;
      insensitive = true;
      term = "kitty";  # or your preferred terminal
    };
  };


  home.packages = with pkgs; [
    neofetch
    fzf
    firefox
    waybar
    hyprpaper
    pavucontrol
    networkmanager
  ];

  xdg.configFile."wofi/style.css".source = ./modules/wofi/style.css;

  home.stateVersion = "24.11";
}
