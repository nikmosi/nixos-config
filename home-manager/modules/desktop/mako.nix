{ pkgs, ... }:
{
  services.mako = {
    enable = true;

    settings = {
      # Tokyo Night palette
      font = "JetBrainsMono Nerd Font Mono 12";
      background-color = "#1a1b26";
      text-color = "#c0caf5";
      border-color = "#7aa2f7";
      progress-color = "over #3b4261";

      width = 400;
      height = 200;
      margin = "10";
      padding = "12";
      border-size = 2;
      border-radius = 6;

      default-timeout = 45000;
      ignore-timeout = true;

      markup = true;
      actions = true;
      icons = true;
      max-icon-size = 48;
      icon-path = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";

      layer = "top";
      anchor = "top-right";

      # Per-urgency styling
      "urgency=low" = {
        background-color = "#1a1b26";
        border-color = "#565f89";
      };
      "urgency=normal" = {
        background-color = "#1a1b26";
        border-color = "#7aa2f7";
      };
      "urgency=critical" = {
        background-color = "#1a1b26";
        text-color = "#f7768e";
        border-color = "#f7768e";
        default-timeout = 0;
      };
    };
  };
}
