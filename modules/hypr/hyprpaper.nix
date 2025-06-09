# /home/tdmunnik/nix-config/modules/hypr/hyprpaper.nix

{ config, pkgs, ... }:

let
  wallpaper = "/home/tdmunnik/nix-config/modules/backgrounds";
  wallpaperFile = "the-king-is-coming-newspaper.jpg";
  fullPath = "${wallpaperPath}/${wallpaperFile}";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ fullPath ];
      wallpaper = [
        "eDP-1,${fullPath}"
        "DP-1,${fullPath}"
        "HDMI-A-1,${fullPath}"
      ];
      splash = false;
    };
  };
}
