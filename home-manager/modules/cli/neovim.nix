{ pkgs, unstable, ... }:
{
  programs.neovim = {
    enable = true;
    package = unstable.neovim;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };
}
