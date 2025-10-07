{
  xdg.mimeApps.enable = true;

  xdg.mimeApps.defaultApplications = {
    "application/json" = "firefox.desktop";
    "application/pdf" = "org.pwmt.zathura.desktop;firefox.desktop;sioyek.desktop";
    "application/vnd.mozilla.xul+xml" = "firefox.desktop";
    "application/x-xdg-protocol-tg" = "org.telegram.desktop.desktop";
    "application/x-xpinstall" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";

    "image/bmp" = "feh.desktop";
    "image/gif" = "feh.desktop";
    "image/heic" = "feh.desktop";
    "image/jpeg" = "feh.desktop";
    "image/jpg" = "feh.desktop";
    "image/pjpeg" = "feh.desktop";
    "image/png" = "feh.desktop";
    "image/tiff" = "feh.desktop";
    "image/webp" = "feh.desktop";
    "image/x-bmp" = "feh.desktop";
    "image/x-pcx" = "feh.desktop";
    "image/x-png" = "feh.desktop";
    "image/x-portable-anymap" = "feh.desktop";
    "image/x-portable-bitmap" = "feh.desktop";
    "image/x-portable-graymap" = "feh.desktop";
    "image/x-portable-pixmap" = "feh.desktop";
    "image/x-tga" = "feh.desktop";
    "image/x-xbitmap" = "feh.desktop";

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

    # дефолты из твоего файла: ECZHD3 и S2NHD3
    "x-scheme-handler/tg" = "userapp-AyuGram Desktop-ECZHD3.desktop";
    "x-scheme-handler/tonsite" = "userapp-AyuGram Desktop-S2NHD3.desktop";
  };

  xdg.mimeApps.associations.added = {
    "application/pdf" = "org.pwmt.zathura.desktop;zathura.desktop";
    "inode/directory" = "thunar.desktop";

    # объединено: INCJK2; QQTK02; ECZHD3
    "x-scheme-handler/tg" =
      "userapp-AyuGram Desktop-INCJK2.desktop;userapp-AyuGram Desktop-QQTK02.desktop;userapp-AyuGram Desktop-ECZHD3.desktop";

    # объединено: 9PA1S2; KYFK02; S2NHD3
    "x-scheme-handler/tonsite" =
      "userapp-AyuGram Desktop-9PA1S2.desktop;userapp-AyuGram Desktop-KYFK02.desktop;userapp-AyuGram Desktop-S2NHD3.desktop";
  };
}
