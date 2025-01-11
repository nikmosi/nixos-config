{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        draw_bold_text_with_bright_colors = true;
        bright = {
          black = "#928374";
          blue = "#83a598";
          cyan = "#8ec07c";
          green = "#b8bb26";
          magenta = "#d3869b";
          red = "#fb4934";
          white = "#ebdbb2";
          yellow = "#fabd2f";
        };
        normal = {
          black = "#282828";
          blue = "#458588";
          cyan = "#689d6a";
          green = "#98971a";
          magenta = "#b16286";
          red = "#cc241d";
          white = "#d3d3d3";
          yellow = "#d79921";
        };
        primary = {
          background = "#000000";
          foreground = "#ebdbb2";
        };
      };

      cursor = {
        style = {
          shape = "Beam";
        };
      };

      env = {
        TERM = "xterm-256color";
      };

      font = {
        size = 12;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "Source Code Pro";
          style = "Bold";
        };
        italic = {
          family = "Source Code Pro";
          style = "Italic";
        };
        bold_italic = {
          family = "Source Code Pro";
          style = "Bold Italic";
        };
        offset = {
          x = 0;
          y = 1;
        };
      };

      keyboard = {
        bindings = [
          {
            action = "Paste";
            key = "V";
            mods = "Control|Shift";
          }
          {
            action = "Copy";
            key = "C";
            mods = "Control|Shift";
          }
          {
            action = "PasteSelection";
            key = "Insert";
            mods = "Shift";
          }
          {
            action = "ResetFontSize";
            key = "Key0";
            mods = "Control";
          }
          {
            action = "IncreaseFontSize";
            key = "Equals";
            mods = "Control";
          }
          {
            action = "IncreaseFontSize";
            key = "Plus";
            mods = "Control";
          }
          {
            action = "DecreaseFontSize";
            key = "Minus";
            mods = "Control";
          }
          {
            action = "ToggleFullscreen";
            key = "F11";
            mods = "None";
          }
          {
            action = "Paste";
            key = "Paste";
            mods = "None";
          }
          {
            action = "Copy";
            key = "Copy";
            mods = "None";
          }
          {
            action = "ClearLogNotice";
            key = "L";
            mods = "Control";
          }
          {
            chars = "\f";
            key = "L";
            mods = "Control";
          }
          {
            action = "ScrollPageUp";
            key = "PageUp";
            mode = "~Alt";
            mods = "None";
          }
          {
            action = "ScrollPageDown";
            key = "PageDown";
            mode = "~Alt";
            mods = "None";
          }
          {
            action = "ScrollToTop";
            key = "Home";
            mode = "~Alt";
            mods = "Shift";
          }
          {
            action = "ScrollToBottom";
            key = "End";
            mode = "~Alt";
            mods = "Shift";
          }
        ];
      };

      scrolling = {
        history = 5000;
      };

      window = {
        dynamic_padding = true;
        opacity = 1.0;
        title = "Alacritty";
        class = {
          general = "Alacritty";
          instance = "Alacritty";
        };
      };
    };
  };
}
