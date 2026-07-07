{
  config,
  pkgs,
  ...
}:
let
  # Tokyo Night palette — matches mako.nix / niri.nix / waybar.nix / rofi.nix
  c = {
    bg = "#1a1b26";
    bgAlt = "#1f2335";
    fg = "#c0caf5";
    blue = "#7aa2f7";
    purple = "#bb9af7";
    yellow = "#e0af68";
    red = "#f7768e";
    comment = "#565f89";
  };

  wallpaper = "${config.home.homeDirectory}/Pictures/wallpaper/cyberpunk-nun-halo-anime-sci-fi-4k-wallpaper-uhdpaper.com-739@0@j.jpg";
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      # ── Background ───────────────────────────────────────
      image = wallpaper;
      scaling = "fill";
      color = c.bg;
      effect-blur = "10x3";
      effect-vignette = "0.5:0.5";
      fade-in = 0.2;

      # ── Clock (swaylock-effects) ─────────────────────────
      clock = true;
      timestr = "%H:%M";
      datestr = "%a, %d %b %Y";
      font = "JetBrainsMono Nerd Font";
      font-size = 28;

      # ── Indicator ────────────────────────────────────────
      indicator = true;
      indicator-radius = 120;
      indicator-thickness = 12;

      # Default (idle) state
      inside-color = "${c.bg}cc";
      ring-color = c.comment;
      line-color = c.bgAlt;
      separator-color = c.bgAlt;
      text-color = c.fg;
      key-hold-color = c.bgAlt;
      bsw-color = c.comment;

      # Verifying (typing password)
      inside-ver-color = "${c.purple}cc";
      ring-ver-color = c.purple;
      line-ver-color = c.purple;
      text-ver-color = c.bg;
      separator-ver-color = c.purple;

      # Clear (caps-lock etc.)
      inside-clear-color = "${c.yellow}cc";
      ring-clear-color = c.yellow;
      line-clear-color = c.yellow;
      text-clear-color = c.bg;
      separator-clear-color = c.yellow;

      # Wrong (auth failed)
      inside-wrong-color = "${c.red}cc";
      ring-wrong-color = c.red;
      line-wrong-color = c.red;
      text-wrong-color = c.bg;
      separator-wrong-color = c.red;

      # ── Behaviour ─────────────────────────────────────────
      grace = 3;
      grace-no-mouse = true;
      grace-no-touch = true;
      ignore-empty-password = true;
      show-failed-attempts = true;
    };
  };
}
