{
  services.picom = {
    enable = true;
    settings = {
      backend = "glx";
      glx-copy-from-front = true;
      glx-swap-method = 2;
      glx-use-copysubbuffer-mesa = true;
      unredir-if-possible = false;
      vsync = true;
      xrender-sync = true;
      xrender-sync-fence = true;
    };
  };
}
