{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        fullscreen = false;
        geometry = "300x50-10+50";
        layer = "above";
        startup_notification = false;
        timeout = 90;
        stack_duplicates = true;
        format = "<b>%s</b>";
        separator_height = 2;
        padding = 12;
        transparency = 5;
        frame_width = 2;
        dpi = 96;
        mouse = true;
        icon_position = "left";
        max_icon_size = 48;
        follow = "mouse";
      };

      frame = {
        frame_color = "#3c3836";
      };

      shadows = {
        enabled = true;
        radius = 15;
        opacity = "0.6";
        offset_x = 2;
        offset_y = 4;
        color = "#000000";
      };
    };
  };
}
