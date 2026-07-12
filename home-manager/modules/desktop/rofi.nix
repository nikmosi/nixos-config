{
  config,
  pkgs,
  lib,
  ...
}:
let
  p = config.dotfiles.palette;
in
{
  config = lib.mkIf config.local.desktop.rofi.enable {
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
        modi = "drun,run,window,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
        show-icons = true;
        icon-theme = "Papirus-Dark";
        font = "JetBrainsMono Nerd Font Mono 14";
        display-drun = "Apps";
        display-run = "Run";
        display-window = "Windows";
        display-power-menu = "Power";
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
      };
      theme =
        let
          inherit (config.lib.formats.rasi) mkLiteral;
          c = {
            bg = p.base;
            bg-alt = p.surface0;
            bg-hover = p.surface1;
            fg = p.text;
            fg-dim = p.overlay0;
            inherit (p) blue;
            inherit (p) green;
            inherit (p) red;
            inherit (p) yellow;
            cyan = p.teal;
            purple = p.mauve;
          };
        in
        {
          # ── Global palette & resets ─────────────────────────
          "*" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral c.fg;
            border-color = mkLiteral c.bg-alt;
            margin = mkLiteral "0px";
            padding = mkLiteral "0px";
            spacing = mkLiteral "0px";
          };

          # ── Window ──────────────────────────────────────────
          "window" = {
            width = mkLiteral "38%";
            height = mkLiteral "44%";
            padding = mkLiteral "14px";
            border = mkLiteral "2px";
            border-radius = mkLiteral "14px";
            background-color = mkLiteral c.bg;
            border-color = mkLiteral c.bg-alt;
          };

          "mainbox" = {
            padding = mkLiteral "0px";
            spacing = mkLiteral "8px";
          };

          # ── Input bar ───────────────────────────────────────
          "inputbar" = {
            padding = mkLiteral "10px 14px";
            spacing = mkLiteral "8px";
            border-radius = mkLiteral "10px";
            background-color = mkLiteral c.bg-alt;
          };

          "prompt" = {
            text-color = mkLiteral c.blue;
          };

          "entry" = {
            placeholder = "Search...";
            placeholder-color = mkLiteral c.fg-dim;
            text-color = mkLiteral c.fg;
            cursor = mkLiteral "text";
          };

          "case-indicator" = {
            text-color = mkLiteral c.fg-dim;
          };

          "num-filtered-rows" = {
            expand = false;
            text-color = mkLiteral c.fg-dim;
          };

          "num-rows" = {
            expand = false;
            text-color = mkLiteral c.fg-dim;
          };

          "textbox-num-sep" = {
            expand = false;
            str = "/";
            text-color = mkLiteral c.fg-dim;
          };

          # ── List ────────────────────────────────────────────
          "listview" = {
            padding = mkLiteral "4px 0px 0px";
            spacing = mkLiteral "4px";
            lines = 10;
            columns = 1;
            fixed-height = false;
            scrollbar = true;
            border = mkLiteral "0px";
          };

          "scrollbar" = {
            width = mkLiteral "4px";
            padding = mkLiteral "0px";
            handle-width = mkLiteral "8px";
            handle-color = mkLiteral c.fg-dim;
          };

          # ── Elements (all states for every mode) ────────────
          "element" = {
            padding = mkLiteral "8px 12px";
            spacing = mkLiteral "10px";
            border-radius = mkLiteral "8px";
            cursor = mkLiteral "pointer";
          };

          "element normal.normal" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral c.fg;
          };

          "element normal.urgent" = {
            text-color = mkLiteral c.yellow;
          };

          "element normal.active" = {
            text-color = mkLiteral c.blue;
          };

          "element selected.normal" = {
            background-color = mkLiteral c.blue;
            text-color = mkLiteral c.bg;
          };

          "element selected.urgent" = {
            background-color = mkLiteral c.yellow;
            text-color = mkLiteral c.bg;
          };

          "element selected.active" = {
            background-color = mkLiteral c.blue;
            text-color = mkLiteral c.bg;
          };

          "element alternate.normal" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral c.fg;
          };

          "element-icon" = {
            size = mkLiteral "24px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
          };

          "element-text" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
          };

          # ── Message (power-menu confirm, mode switcher) ─────
          "message" = {
            padding = mkLiteral "8px 12px";
            border-radius = mkLiteral "8px";
            background-color = mkLiteral c.bg-alt;
          };

          "textbox" = {
            text-color = mkLiteral c.fg;
          };

          # ── Sidebar (mode tabs) ─────────────────────────────
          "sidebar" = {
            padding = mkLiteral "8px 0px 0px";
          };

          "button" = {
            padding = mkLiteral "6px 12px";
            spacing = mkLiteral "8px";
            border-radius = mkLiteral "8px";
            cursor = mkLiteral "pointer";
            text-color = mkLiteral c.fg-dim;
          };

          "button selected" = {
            background-color = mkLiteral c.bg-hover;
            text-color = mkLiteral c.blue;
          };
        };
    };
  };
}
