{ config, lib, ... }:
{
  config = lib.mkIf config.local.desktop.mimeapps.enable {
    xdg = {
      mimeApps = {
        enable = true;
        defaultApplications = {
          "application/json" = "firefox.desktop";
          "application/pdf" = "org.pwmt.zathura.desktop;firefox.desktop";
          "application/vnd.mozilla.xul+xml" = "firefox.desktop";
          "application/x-xdg-protocol-tg" = "org.telegram.desktop.desktop";
          "application/x-xpinstall" = "firefox.desktop";
          "application/xhtml+xml" = "firefox.desktop";
          "inode/directory" = "yazi.desktop;thunar.desktop";
          "modrinth" = "modrinth-app-handler.desktop";
          "text/html" = "firefox.desktop";
          "text/mml" = "firefox.desktop";
          "text/xml" = "firefox.desktop";
          "x-scheme-handler/discord" = "vesktop.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/okular" = "pdf-view-opener.desktop";
          "x-scheme-handler/postman" = "Postman.desktop";
          "x-scheme-handler/tg" = "userapp-AyuGram Desktop-ECZHD3.desktop";
          "x-scheme-handler/tonsite" = "userapp-AyuGram Desktop-S2NHD3.desktop";

          # image types – feh + imv
          "image/avif" = "feh.desktop;imv.desktop";
          "image/bmp" = "feh.desktop;imv.desktop";
          "image/gif" = "feh.desktop;imv.desktop";
          "image/heic" = "feh.desktop;imv.desktop";
          "image/heif" = "feh.desktop;imv.desktop";
          "image/jpeg" = "feh.desktop;imv.desktop";
          "image/jpg" = "feh.desktop;imv.desktop";
          "image/jxl" = "imv.desktop;feh.desktop";
          "image/pjpeg" = "feh.desktop;imv.desktop";
          "image/png" = "feh.desktop;imv.desktop";
          "image/qoi" = "imv.desktop;feh.desktop";
          "image/svg+xml" = "imv.desktop;feh.desktop;firefox.desktop";
          "image/tiff" = "feh.desktop;imv.desktop";
          "image/webp" = "feh.desktop;imv.desktop";
          "image/x-bmp" = "feh.desktop;imv.desktop";
          "image/x-farbfeld" = "imv.desktop";
          "image/x-pcx" = "feh.desktop";
          "image/x-png" = "feh.desktop;imv.desktop";
          "image/x-portable-anymap" = "feh.desktop";
          "image/x-portable-bitmap" = "feh.desktop";
          "image/x-portable-graymap" = "feh.desktop";
          "image/x-portable-pixmap" = "feh.desktop";
          "image/x-tga" = "feh.desktop";
          "image/x-xbitmap" = "feh.desktop";

          # audio types → mpv
          "audio/3gpp" = "mpv.desktop";
          "audio/3gpp2" = "mpv.desktop";
          "audio/aac" = "mpv.desktop";
          "audio/ac3" = "mpv.desktop";
          "audio/amr-wb" = "mpv.desktop";
          "audio/AMR" = "mpv.desktop";
          "audio/dv" = "mpv.desktop";
          "audio/eac3" = "mpv.desktop";
          "audio/flac" = "mpv.desktop";
          "audio/m3u" = "mpv.desktop";
          "audio/m4a" = "mpv.desktop";
          "audio/mp1" = "mpv.desktop";
          "audio/mp2" = "mpv.desktop";
          "audio/mp3" = "mpv.desktop";
          "audio/mp4" = "mpv.desktop";
          "audio/mpeg" = "mpv.desktop";
          "audio/mpeg2" = "mpv.desktop";
          "audio/mpeg3" = "mpv.desktop";
          "audio/mpegurl" = "mpv.desktop";
          "audio/mpg" = "mpv.desktop";
          "audio/musepack" = "mpv.desktop";
          "audio/ogg" = "mpv.desktop";
          "audio/opus" = "mpv.desktop";
          "audio/rn-mpeg" = "mpv.desktop";
          "audio/scpls" = "mpv.desktop";
          "audio/vnd.dolby.heaac.1" = "mpv.desktop";
          "audio/vnd.dolby.heaac.2" = "mpv.desktop";
          "audio/vnd.dts" = "mpv.desktop";
          "audio/vnd.dts.hd" = "mpv.desktop";
          "audio/vnd.rn-realaudio" = "mpv.desktop";
          "audio/vnd.wave" = "mpv.desktop";
          "audio/vorbis" = "mpv.desktop";
          "audio/wav" = "mpv.desktop";
          "audio/webm" = "mpv.desktop";
          "audio/x-aac" = "mpv.desktop";
          "audio/x-adpcm" = "mpv.desktop";
          "audio/x-aiff" = "mpv.desktop";
          "audio/x-ape" = "mpv.desktop";
          "audio/x-m4a" = "mpv.desktop";
          "audio/x-matroska" = "mpv.desktop";
          "audio/x-mp1" = "mpv.desktop";
          "audio/x-mp2" = "mpv.desktop";
          "audio/x-mp3" = "mpv.desktop";
          "audio/x-mpegurl" = "mpv.desktop";
          "audio/x-mpg" = "mpv.desktop";
          "audio/x-ms-asf" = "mpv.desktop";
          "audio/x-ms-wma" = "mpv.desktop";
          "audio/x-musepack" = "mpv.desktop";
          "audio/x-pls" = "mpv.desktop";
          "audio/x-pn-au" = "mpv.desktop";
          "audio/x-pn-realaudio" = "mpv.desktop";
          "audio/x-pn-wav" = "mpv.desktop";
          "audio/x-pn-windows-pcm" = "mpv.desktop";
          "audio/x-realaudio" = "mpv.desktop";
          "audio/x-scpls" = "mpv.desktop";
          "audio/x-shorten" = "mpv.desktop";
          "audio/x-tta" = "mpv.desktop";
          "audio/x-vorbis" = "mpv.desktop";
          "audio/x-vorbis+ogg" = "mpv.desktop";
          "audio/x-wav" = "mpv.desktop";
          "audio/x-wavpack" = "mpv.desktop";

          # video types → mpv
          "application/mxf" = "mpv.desktop";
          "application/ogg" = "mpv.desktop";
          "application/sdp" = "mpv.desktop";
          "application/smil" = "mpv.desktop";
          "application/streamingmedia" = "mpv.desktop";
          "application/vnd.apple.mpegurl" = "mpv.desktop";
          "application/vnd.ms-asf" = "mpv.desktop";
          "application/vnd.rn-realmedia" = "mpv.desktop";
          "application/vnd.rn-realmedia-vbr" = "mpv.desktop";
          "application/x-cue" = "mpv.desktop";
          "application/x-extension-m4a" = "mpv.desktop";
          "application/x-extension-mp4" = "mpv.desktop";
          "application/x-matroska" = "mpv.desktop";
          "application/x-mpegurl" = "mpv.desktop";
          "application/x-ogg" = "mpv.desktop";
          "application/x-ogm" = "mpv.desktop";
          "application/x-ogm-audio" = "mpv.desktop";
          "application/x-ogm-video" = "mpv.desktop";
          "application/x-shorten" = "mpv.desktop";
          "application/x-smil" = "mpv.desktop";
          "application/x-streamingmedia" = "mpv.desktop";
          "video/3gp" = "mpv.desktop";
          "video/3gpp" = "mpv.desktop";
          "video/3gpp2" = "mpv.desktop";
          "video/avi" = "mpv.desktop";
          "video/divx" = "mpv.desktop";
          "video/dv" = "mpv.desktop";
          "video/fli" = "mpv.desktop";
          "video/flv" = "mpv.desktop";
          "video/mkv" = "mpv.desktop";
          "video/mp2t" = "mpv.desktop";
          "video/mp4" = "mpv.desktop";
          "video/mp4v-es" = "mpv.desktop";
          "video/mpeg" = "mpv.desktop";
          "video/msvideo" = "mpv.desktop";
          "video/ogg" = "mpv.desktop";
          "video/quicktime" = "mpv.desktop";
          "video/vnd.avi" = "mpv.desktop";
          "video/vnd.divx" = "mpv.desktop";
          "video/vnd.mpegurl" = "mpv.desktop";
          "video/vnd.rn-realvideo" = "mpv.desktop";
          "video/webm" = "mpv.desktop";
          "video/x-avi" = "mpv.desktop";
          "video/x-flic" = "mpv.desktop";
          "video/x-flc" = "mpv.desktop";
          "video/x-flv" = "mpv.desktop";
          "video/x-m4v" = "mpv.desktop";
          "video/x-matroska" = "mpv.desktop";
          "video/x-mpeg2" = "mpv.desktop";
          "video/x-mpeg3" = "mpv.desktop";
          "video/x-ms-afs" = "mpv.desktop";
          "video/x-ms-asf" = "mpv.desktop";
          "video/x-ms-wmv" = "mpv.desktop";
          "video/x-ms-wmx" = "mpv.desktop";
          "video/x-ms-wvxvideo" = "mpv.desktop";
          "video/x-msvideo" = "mpv.desktop";
          "video/x-ogm" = "mpv.desktop";
          "video/x-ogm+ogg" = "mpv.desktop";
          "video/x-theora" = "mpv.desktop";
          "video/x-theora+ogg" = "mpv.desktop";
        };
        associations.added = {
          "application/pdf" = "org.pwmt.zathura.desktop;zathura.desktop";
          "inode/directory" = "thunar.desktop";

          # объединено: INCJK2; QQTK02; ECZHD3
          "x-scheme-handler/tg" =
            "userapp-AyuGram Desktop-INCJK2.desktop;userapp-AyuGram Desktop-QQTK02.desktop;userapp-AyuGram Desktop-ECZHD3.desktop";

          # объединено: 9PA1S2; KYFK02; S2NHD3
          "x-scheme-handler/tonsite" =
            "userapp-AyuGram Desktop-9PA1S2.desktop;userapp-AyuGram Desktop-KYFK02.desktop;userapp-AyuGram Desktop-S2NHD3.desktop";
        };
      };
      configFile."mimeapps.list".force = true;
    };
  };
}
