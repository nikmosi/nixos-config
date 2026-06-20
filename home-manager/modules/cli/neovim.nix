{ lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };

  # Keep the existing init.lua from the dotfiles-managed nvim directory.
  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;
}
