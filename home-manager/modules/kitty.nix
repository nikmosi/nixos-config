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

    # Extended colors (color16 to color255)
    color16 = "#7c6f64"; # base red
    color17 = "#9d0006"; # base red (intense)
    color18 = "#79740e"; # base green
    color19 = "#b57614"; # base yellow
    color20 = "#076678"; # base blue
    color21 = "#8f3f2f"; # base magenta
    color22 = "#558b2f"; # base cyan
    color23 = "#d79921"; # base white
    color24 = "#458588"; # blue
    color25 = "#d3869b"; # magenta
    color26 = "#8ec07c"; # cyan
    color27 = "#fabd2f"; # yellow
    color28 = "#83a598"; # blue
    color29 = "#b16286"; # magenta
    color30 = "#689d6a"; # cyan
    color31 = "#fb4934"; # red
    color32 = "#ebdbb2"; # white

    # Continue for the rest of the colors (color33 to color255)
    color33 = "#504945"; # base neutral gray
    color34 = "#3c3836"; # base darker gray
    color35 = "#665c54"; # base middle gray
    color36 = "#7c6f64"; # base brown
    color37 = "#9d0006"; # base red
    color38 = "#9d0006"; # base red
    color39 = "#79740e"; # base green
    color40 = "#b57614"; # base yellow
    color41 = "#076678"; # blue
    color42 = "#8f3f2f"; # magenta
    color43 = "#558b2f"; # cyan
    color44 = "#d79921"; # yellow
    color45 = "#458588"; # blue
    color46 = "#d3869b"; # magenta
    color47 = "#8ec07c"; # cyan
    color48 = "#fabd2f"; # yellow
    color49 = "#83a598"; # blue
    color50 = "#b16286"; # magenta
    color51 = "#689d6a"; # cyan
    color52 = "#fb4934"; # red
    color53 = "#ebdbb2"; # white
    color54 = "#504945"; # base gray
    color55 = "#3c3836"; # base darker gray
    color56 = "#665c54"; # base middle gray
    color57 = "#7c6f64"; # base brown
    color58 = "#9d0006"; # base red
    color59 = "#9d0006"; # base red
    color60 = "#79740e"; # base green
    color61 = "#b57614"; # base yellow
    color62 = "#076678"; # blue
    color63 = "#8f3f2f"; # magenta
    color64 = "#558b2f"; # cyan
    color65 = "#d79921"; # yellow
    color66 = "#458588"; # blue
    color67 = "#d3869b"; # magenta
    color68 = "#8ec07c"; # cyan
    color69 = "#fabd2f"; # yellow
    color70 = "#83a598"; # blue
    color71 = "#b16286"; # magenta
    color72 = "#689d6a"; # cyan
    color73 = "#fb4934"; # red
    color74 = "#ebdbb2"; # white
    color75 = "#504945"; # base gray
    color76 = "#3c3836"; # base darker gray
    color77 = "#665c54"; # base middle gray
    color78 = "#7c6f64"; # base brown
    color79 = "#9d0006"; # base red
    color80 = "#9d0006"; # base red
    color81 = "#79740e"; # base green
    color82 = "#b57614"; # base yellow
    color83 = "#076678"; # blue
    color84 = "#8f3f2f"; # magenta
    color85 = "#558b2f"; # cyan
    color86 = "#d79921"; # yellow
    color87 = "#458588"; # blue
    color88 = "#d3869b"; # magenta
    color89 = "#8ec07c"; # cyan
    color90 = "#fabd2f"; # yellow
    color91 = "#83a598"; # blue
    color92 = "#b16286"; # magenta
    color93 = "#689d6a"; # cyan
    color94 = "#fb4934"; # red
    color95 = "#ebdbb2"; # white
    color96 = "#504945"; # base gray
    color97 = "#3c3836"; # base darker gray
    color98 = "#665c54"; # base middle gray
    color99 = "#7c6f64"; # base brown
    color100 = "#9d0006"; # base red
    color101 = "#3c3836"; # base darker gray
    color102 = "#665c54"; # base middle gray
    color103 = "#7c6f64"; # base brown
    color104 = "#9d0006"; # base red
    color105 = "#9d0006"; # base red
    color106 = "#79740e"; # base green
    color107 = "#b57614"; # base yellow
    color108 = "#076678"; # base blue
    color109 = "#8f3f2f"; # base magenta
    color110 = "#558b2f"; # base cyan
    color111 = "#d79921"; # base white
    color112 = "#458588"; # blue
    color113 = "#d3869b"; # magenta
    color114 = "#8ec07c"; # cyan
    color115 = "#fabd2f"; # yellow
    color116 = "#83a598"; # blue
    color117 = "#b16286"; # magenta
    color118 = "#689d6a"; # cyan
    color119 = "#fb4934"; # red
    color120 = "#ebdbb2"; # white
    color121 = "#504945"; # base gray
    color122 = "#3c3836"; # base darker gray
    color123 = "#665c54"; # base middle gray
    color124 = "#7c6f64"; # base brown
    color125 = "#9d0006"; # base red
    color126 = "#9d0006"; # base red
    color127 = "#79740e"; # base green
    color128 = "#b57614"; # base yellow
    color129 = "#076678"; # blue
    color130 = "#8f3f2f"; # magenta
    color131 = "#558b2f"; # cyan
    color132 = "#d79921"; # yellow
    color133 = "#458588"; # blue
    color134 = "#d3869b"; # magenta
    color135 = "#8ec07c"; # cyan
    color136 = "#fabd2f"; # yellow
    color137 = "#83a598"; # blue
    color138 = "#b16286"; # magenta
    color139 = "#689d6a"; # cyan
    color140 = "#fb4934"; # red
    color141 = "#ebdbb2"; # white
    color142 = "#504945"; # base gray
    color143 = "#3c3836"; # base darker gray
    color144 = "#665c54"; # base middle gray
    color145 = "#7c6f64"; # base brown
    color146 = "#9d0006"; # base red
    color147 = "#9d0006"; # base red
    color148 = "#79740e"; # base green
    color149 = "#b57614"; # base yellow
    color150 = "#076678"; # blue
    color151 = "#8f3f2f"; # magenta
    color152 = "#558b2f"; # cyan
    color153 = "#d79921"; # yellow
    color154 = "#458588"; # blue
    color155 = "#d3869b"; # magenta
    color156 = "#8ec07c"; # cyan
    color157 = "#fabd2f"; # yellow
    color158 = "#83a598"; # blue
    color159 = "#b16286"; # magenta
    color160 = "#689d6a"; # cyan
    color161 = "#fb4934"; # red
    color162 = "#ebdbb2"; # white
    color163 = "#504945"; # base gray
    color164 = "#3c3836"; # base darker gray
    color165 = "#665c54"; # base middle gray
    color166 = "#7c6f64"; # base brown
    color167 = "#9d0006"; # base red
    color168 = "#9d0006"; # base red
    color169 = "#79740e"; # base green
    color170 = "#b57614"; # base yellow
    color171 = "#076678"; # blue
    color172 = "#8f3f2f"; # magenta
    color173 = "#558b2f"; # cyan
    color174 = "#d79921"; # yellow
    color175 = "#458588"; # blue
    color176 = "#d3869b"; # magenta
    color177 = "#8ec07c"; # cyan
    color178 = "#fabd2f"; # yellow
    color179 = "#83a598"; # blue
    color180 = "#b16286"; # magenta
    color181 = "#689d6a"; # cyan
    color182 = "#fb4934"; # red
    color183 = "#ebdbb2"; # white
    color184 = "#504945"; # base gray
    color185 = "#3c3836"; # base darker gray
    color186 = "#665c54"; # base middle gray
    color187 = "#7c6f64"; # base brown
    color188 = "#9d0006"; # base red
    color189 = "#9d0006"; # base red
    color190 = "#79740e"; # base green
    color191 = "#b57614"; # base yellow
    color192 = "#076678"; # blue
    color193 = "#8f3f2f"; # magenta
    color194 = "#558b2f"; # cyan
    color195 = "#d79921"; # yellow
    color196 = "#458588"; # blue
    color197 = "#d3869b"; # magenta
    color198 = "#8ec07c"; # cyan
    color199 = "#fabd2f"; # yellow
    color200 = "#83a598"; # blue
    color201 = "#b16286"; # magenta
    color202 = "#689d6a"; # cyan
    color203 = "#fb4934"; # red
    color204 = "#ebdbb2"; # white
    color205 = "#504945"; # base gray
    color206 = "#3c3836"; # base darker gray
    color207 = "#665c54"; # base middle gray
    color208 = "#7c6f64"; # base brown
    color209 = "#9d0006"; # base red
    color210 = "#9d0006"; # base red
    color211 = "#79740e"; # base green
    color212 = "#b57614"; # base yellow
    color213 = "#076678"; # blue
    color214 = "#8f3f2f"; # magenta
    color215 = "#558b2f"; # cyan
    color216 = "#d79921"; # yellow
    color217 = "#458588"; # blue
    color218 = "#d3869b"; # magenta
    color219 = "#8ec07c"; # cyan
    color220 = "#fabd2f"; # yellow
    color221 = "#83a598"; # blue
    color222 = "#b16286"; # magenta
    color223 = "#689d6a"; # cyan
    color224 = "#fb4934"; # red
    color225 = "#ebdbb2"; # white
    color226 = "#504945"; # base gray
    color227 = "#3c3836"; # base darker gray
    color228 = "#665c54"; # base middle gray
    color229 = "#7c6f64"; # base brown
    color230 = "#9d0006"; # base red
    color231 = "#9d0006"; # base red
    color232 = "#79740e"; # base green
    color233 = "#b57614"; # base yellow
    color234 = "#076678"; # blue
    color235 = "#8f3f2f"; # magenta
    color236 = "#558b2f"; # cyan
    color237 = "#d79921"; # yellow
    color238 = "#458588"; # blue
    color239 = "#d3869b"; # magenta
    color240 = "#8ec07c"; # cyan
    color241 = "#fabd2f"; # yellow
    color242 = "#83a598"; # blue
    color243 = "#b16286"; # magenta
    color244 = "#689d6a"; # cyan
    color246 = "#ebdbb2"; # white
    color247 = "#504945"; # base gray
    color248 = "#3c3836"; # base darker gray
    color249 = "#665c54"; # base middle gray
    color250 = "#7c6f64"; # base brown
    color251 = "#9d0006"; # base red
    color252 = "#9d0006"; # base red
    color253 = "#79740e"; # base green
    color254 = "#b57614"; # base yellow
    color255 = "#076678"; # blue

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
    settings = kittyConfig;
    extraConfig = extraConfig;
  };
}
