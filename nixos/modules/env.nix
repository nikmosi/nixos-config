{
  environment.sessionVariables = rec {
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
