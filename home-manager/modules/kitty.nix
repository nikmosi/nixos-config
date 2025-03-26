{ ... }:
let
  kittyConfig = {
    # Colors configuration
    background = "#000000";
    foreground = "#ebdbb2";

    # Normal colors
    color0 = "#282828";
    color1 = "#cc241d";
    color2 = "#98971a";
    color3 = "#d79921";
    color4 = "#458588";
    color5 = "#b16286";
    color6 = "#689d6a";
    color7 = "#d3d3d3";

    # Bright colors
    color8 = "#928374";
    color9 = "#fb4934";
    color10 = "#b8bb26";
    color11 = "#fabd2f";
    color12 = "#83a598";
    color13 = "#d3869b";
    color14 = "#8ec07c";
    color15 = "#ebdbb2";

    # Cursor settings
    cursor_color = "#ebdbb2";

    # Font settings
    font_family = "JetBrainsMono Nerd Font";
    font_size = 12;
    bold_font = "Source Code Pro";
    italic_font = "Source Code Pro";

    # Window settings
    window_border_width = 0;
    window_padding_width = 2;
    window_title = "Kitty";
    window_class = "Kitty";

    # Scrolling history
    scrollback_lines = 5000;
  };
  extraConfig = ''
    copy_on_select yes

    # Key bindings
    map ctrl+shift+c copy_to_clipboard;
    map ctrl+shift+v paste_from_clipboard;
    map ctrl+shift+key0 reset_font_size;
    map ctrl+shift+plus increase_font_size;
    map ctrl+shift+minus decrease_font_size;
    map ctrl+shift+f11 toggle_fullscreen;
    map ctrl+l clear_log;
    map shift+pageup scroll_up;
    map shift+pagedown scroll_down;
    map ctrl+shift+home scroll_to_top;
    map ctrl+shift+end scroll_to_bottom;

    # Environment variables
    env TERM=xterm-256color;
  '';
in
{
  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
    settings = kittyConfig;
    extraConfig = extraConfig;
  };
}
