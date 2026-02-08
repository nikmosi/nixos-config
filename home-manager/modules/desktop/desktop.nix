{ pkgs, ... }:
{

  programs.chromium = {
    enable = true;
    package = pkgs.chromium.override {
      commandLineArgs = [
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
      ];
    };
  };

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        path = "tetr027g.default";
        settings = {
          "gfx.webrender.all" = true;
          "media.ffmpeg.vaapi.enabled" = true;

          # Опционально: если видео глючит, можно отключить песочницу для RDD процесса
          # "widget.dmabuf.force-enabled" = true;
        };
      };

      for_jeens = {
        id = 1;
        name = "for_jeens";
        path = "dcuriwka.for_jeens";
      };
    };
  };

  xdg.desktopEntries.chatterino = {
    name = "Chatterino";
    comment = "Twitch chat client for desktop";
    exec = "chatterino";
    icon = "chatterino";
    terminal = false;
    type = "Application";
    categories = [
      "Network"
      "Chat"
    ];
  };

  xdg.desktopEntries.chromium-custom = {
    name = "Chromium";
    genericName = "Web Browser";
    exec = "${pkgs.chromium}/bin/chromium %U";
    terminal = false;
    icon = "chromium";
    categories = [
      "Application"
      "Network"
      "WebBrowser"
    ];
    mimeType = [
      "text/html"
      "text/xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
  };

  xdg.desktopEntries.modrinthapp = {
    name = "Modrinth App";
    comment = "Minecraft mod manager";
    exec = "ModrinthApp";
    icon = "/home/nik/.local/share/icons/modrinth.png";
    terminal = false;
    type = "Application";
    categories = [ "Game" ];
  };
}
