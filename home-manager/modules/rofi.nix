{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark-hard";
    plugins = with pkgs; [
      rofi-calc
    ];
  };
}
