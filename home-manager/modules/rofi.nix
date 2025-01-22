{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-calc
    ];
    terminal = "${pkgs.alacritty}/bin/alacritty";
    extraConfig = {
      window = {
        location = "center";
        width = "50%";
        height = "40%";
      };
      padding = 20;
    };
  };
}
