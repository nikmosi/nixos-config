{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        timeout = 45;
        stack_duplicates = true;
        format = "<i>%i</i> <b>%s</b>\n%b";
        separator_height = 2;
        padding = 12;
        transparency = 5;
        frame_width = 2;
        icon_position = "left";
        max_icon_size = 48;
        follow = "mouse";
        frame_color = "#3c3836";

        offset = "10x50";
        layer = "normal";
      };
    };
  };
}
