#nix-config/home.nix
{ config, pkgs, ... }:

{
  imports = [
    ./modules/waybar/waybar.nix
    ./modules/hypr/wallpaper.nix
    ./modules/kitty/kitty.nix
    ./modules/neovim/neovim.nix
    ./modules/tmux/tmux.nix
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

  programs.hyprlock = {
    enable = true;
    extraConfig = builtins.readFile ./modules/hypr/lockscreen.conf;
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
    tmux
    waybar
    hyprpaper
    pavucontrol

    docker
    docker-compose
    # virt-manager

    obsidian
    spotify
    discord
    steam
    heroic

    nodejs
    python3
    python3Packages.pip

    insomnia

    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  xdg.configFile."wofi/style.css".source = ./modules/wofi/style.css;

  xdg.configFile."virt-manager.conf".text = ''...''; # Optional customization

  home.stateVersion = "24.11";
}
