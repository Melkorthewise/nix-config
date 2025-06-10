# nix-config/modules/neovim/neovim.nix
{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraConfig = builtins.readFile ./modules/neovim/init.lua;
  };
}
