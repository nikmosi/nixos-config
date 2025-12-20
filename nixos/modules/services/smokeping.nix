{
  services.smokeping.enable = true;
  services.smokeping.targets = {
    main = {
      host = "8.8.8.8";
    };
    cf = {
      host = "1.1.1.1";
    };
    game-like = {
      host = "fra.speedtest.net";
    };
    game = {
      host = "epicgames.com";
    };
    youtube = {
      host = "youtube.com";
    };
  };
}
