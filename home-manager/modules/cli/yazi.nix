{ config, lib, ... }:
let
  draculaYazi = builtins.fetchGit {
    url = "https://github.com/dracula/yazi.git";
    rev = "99b60fd76df4cce2778c7e6c611bfd733cf73866";
  };
in
{
  config = lib.mkIf config.local.cli.yazi.enable {
    home.file.".config/yazi/flavors/dracula.yazi".source = draculaYazi;

    programs.yazi = {
      enable = true;
      enableNushellIntegration = true;
      shellWrapperName = "yy";
      settings = {
        flavors.use = "dracula";
      };
      keymap.mgr.prepend_keymap = [
        {
          on = [ "<C-n>" ];
          run = ''shell "ripdrag -a -x \"$@\" 2>/dev/null &" --confirm'';
        }
      ];
    };
  };
}
