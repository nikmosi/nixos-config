{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.local.cli.atuin.enable {
    programs.atuin = {
      enable = true;
      package = pkgs.unstable.atuin;

      settings = {
        show_preview = true;
        style = "compact";
        inline_height = 15;
        secrets_filter = true;

        history_filter = [
          # Trivial / noise commands
          "^l$"
          "^t$"
          "^clear$"
          "^run$"
          "^nu$"
          "^btop$"
          "^sudo su$"
          # Git aliases — неинформативны в истории
          "^gst$"
          "^glol$"
          "^gp$"
          # Devenv boilerplate
          "^exec \"/run/current-system/sw/bin/nu\""
          "^if \\[ ! -x"
          "^fi$"
          # Строки-комментарии (bash timestamps)
          "^#"
        ];

        cwd_filter = [
          "^/tmp"
          "/.devenv"
        ];

        sync = {
          address = "https://api.atuin.sh";
          frequency = "10m";
        };
      };
    };
  };
}
