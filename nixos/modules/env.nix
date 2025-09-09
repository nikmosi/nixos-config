{ pkgs, ... }:
let
  awesomeLib = "${pkgs.awesome}/share/awesome/lib";
in
{
  environment.sessionVariables = rec {
    AWESOME_LIB = awesomeLib;
    TERMINAL = "kitty";
    MANPAGER = "batman";
    MANROFFOPT = "-c";
    EDITOR = "nvim";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
    WEBKIT_DISABLE_DMABUF_RENDERER = 1;
  };

}
