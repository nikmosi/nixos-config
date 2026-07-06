{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    plugins = with pkgs; [
      rofi-power-menu
    ];
    location = "center";
    yoffset = 0;
    xoffset = 0;
    extraConfig = {
      modi = "drun,run,window,clipboard:${pkgs.cliphist}/bin/cliphist-rofi-img,clipboard-text:${pkgs.cliphist}/bin/cliphist-rofi";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      font = "JetBrainsMono Nerd Font Mono 14";
      display-drun = "Apps";
      display-run = "Run";
      display-window = "Windows";
      display-clipboard = "Clip";
      display-clipboard-text = "Clip Text";
      drun-display-format = "{name}";
      window-format = "{title}";
      sort = true;
      matching = "fuzzy";
      scroll-method = 0;
      cycle = true;
      sidebar-mode = false;
      eh = 1;
      auto-select = false;
      parse-hosts = false;
      parse-known-hosts = false;
      combi-hide-mode-prefix = true;
    };
    theme =
      let
        inherit (pkgs) lib;
        c = {
          bg = "#1a1b26";
          bgHighlight = "#1f2335";
          fg = "#c0caf5";
          blue = "#7aa2f7";
          green = "#9ece6a";
          red = "#f7768e";
          comment = "#565f89";
        };
      in
      {
        "*" = {
          background-color = lib.mkForce c.bg;
          border-color = lib.mkForce c.bgHighlight;
          text-color = lib.mkForce c.fg;
        };
        "window" = {
          width = lib.mkForce "30%";
          height = lib.mkForce "40%";
          padding = lib.mkForce "12px";
          border = lib.mkForce "2px";
          border-radius = lib.mkForce "12px";
        };
        "mainbox" = {
          padding = lib.mkForce "8px";
        };
        "inputbar" = {
          padding = lib.mkForce "8px 12px";
          spacing = lib.mkForce "8px";
          border-radius = lib.mkForce "8px";
          background-color = lib.mkForce c.bgHighlight;
        };
        "prompt" = {
          text-color = lib.mkForce c.blue;
        };
        "entry" = {
          placeholder = "Search...";
          text-color = lib.mkForce c.fg;
        };
        "listview" = {
          padding = lib.mkForce "4px 0";
          lines = 10;
          columns = 1;
          fixed-height = false;
        };
        "element" = {
          padding = lib.mkForce "8px 12px";
          spacing = lib.mkForce "8px";
          border-radius = lib.mkForce "6px";
        };
        "element selected" = {
          background-color = lib.mkForce c.blue;
          text-color = lib.mkForce c.bg;
        };
        "element-icon" = {
          size = lib.mkForce "24px";
        };
      };
  };
}
