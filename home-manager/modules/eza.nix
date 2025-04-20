{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    colors = "always";
    git = true;
    icons = "always";
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
}
