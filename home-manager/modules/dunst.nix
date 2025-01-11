{
  programs.dunst = {
    enable = true;

    settings = {
      global = {
        fullscreen = false;
        geometry = "300x50-10+50";
        layer = "above";
        startup_notification = false;
        timeout = 3000;
        stack_duplicates = true;
        font = "JetBrainsMono Nerd Font 10";
        format = "<b>%s</b>";
        separator_height = 2;
        padding = 12;
        transparency = 5;
        frame_width = 2;
        dpi = 96;
        mouse = true;
        icon_path = [ "/usr/share/icons" "/usr/local/share/icons" ];
        icon_position = "left";
        max_icon_size = 48;
        follow = "mouse";
      };

      frame = {
        frame_color = "#3c3836";
      };

      urgency_low = {
        timeout = 4000;
        background = "#282828";
        foreground = "#ebdbb2";
        frame_color = "#458588";
      };

      urgency_normal = {
        timeout = 3000;
        background = "#3c3836";
        foreground = "#ebdbb2";
        frame_color = "#d79921";
      };

      urgency_critical = {
        timeout = 0;
        background = "#cc241d";
        foreground = "#fbf1c7";
        frame_color = "#fb4934";
      };

      shadows = {
        enabled = true;
        radius = 15;
        opacity = 0.6;
        offset_x = 2;
        offset_y = 4;
        color = "#000000";
      };
    };
  };
}

