{
  home.file.".config/mpv/scripts/recent.lua" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/hacel/recent/master/recent.lua";
      sha256 = "sha256:1kc998vyq43jijrflsp2fn79b52fp6pblr2hc01gwynd2msdki4v"; # replace this
    };
  };
}
