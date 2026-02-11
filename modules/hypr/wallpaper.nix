# /home/tdmunnik/nix-config/modules/hypr/hyprpaper.nix

{ config, pkgs, ... }:

let
  wallpaperPath = "/home/tdmunnik/nix-config/modules/backgrounds";
  wallpapers = builtins.attrNames (builtins.readDir wallpaperPath);
  fullPaths = map (f: "${wallpaperPath}/${f}") wallpapers;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/home/tdmunnik/nix-config/modules/backgrounds/armand-serrano-noahsark.jpg" ];
      wallpaper = [
        "eDP-1,/home/tdmunnik/nix-config/modules/backgrounds/armand-serrano-noahsark.jpg"
        "DP-1,/home/tdmunnik/nix-config/modules/backgrounds/armand-serrano-noahsark.jpg"
      ];
      splash = false;
    };
  };
}
