{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    keyMode = "vi";
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
