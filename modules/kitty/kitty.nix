# nix-config/modules/kitty/kitty.nix
{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    extraConfig = ''
      font_family JetBrainsMono Nerd Font
      font_size 14.0

      # Set font and size
      font_family JetBrainsMono Nerd Font
      font_size 14.0
      
      # Background and Foreground
      background #151515
      foreground #948487
      background_opacity 0.9
      
      # ANSI Colors (color0 to color7)
      color0  #151515
      color1  #80281B
      color2  #D57C39
      color3  #262C42
      color4  #58555C
      color5  #948487
      color6  #80281B
      color7  #453633
      
      # Bright Colors (color8 to color15)
      color8  #58555C
      color9  #471D0E
      color10 #D57C39
      color11 #262C42
      color12 #948487
      color13 #363544
      color14 #80281B
      color15 #3F3E4E
      
      # Cursor and Selection Colors
      cursor  #E1A66B
      selection_foreground #ffffff
      selection_background #E5B27E
      
      # Optional: Window Border and Focus
      active_border_color #E1A66B
      inactive_border_color #555555
    '';
  };
}
