{
  lib,
  pkgs,
  config,
  ...
}:
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

  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;

  xdg.configFile."nvim".source =
    if config.dotfiles.mutable then
      config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.path}/home-manager/modules/cli/nvim"
    else
      ./nvim;
}
