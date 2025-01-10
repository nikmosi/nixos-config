{ pkgs, config, ... }:

{
  home.username = "nik";
  home.homeDirectory = "/home/nik";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # fonts
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
      ];
    })
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    weather-icons

    # pass
    passff-host

    eza
    fzf
    git
    maim
    pre-commit
    rofi
    source-code-pro
    stow
    zbar
    zoxide

    # lsp
    docker-compose-language-service
    docker-ls
    lua-language-server
    nil
    pyright
    python312Packages.python-lsp-server
    ripdrag
    ruff
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  fonts.fontconfig.enable = true;

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [
      exts.pass-update
      exts.pass-otp
      exts.pass-import
      exts.pass-genphrase
    ]);
    settings = {
      PASSWORD_STORE_DIR = "${config.xdg.dataHome}/.password-store";
    };
  };

  programs.git = {
    enable = true;
    userName = "nikmosi";
    userEmail = "i@nikmosi.ru";
    signing = {
      key = "B77DD388609E81892CBC2D6AB9CF67BBE64E1273";
      signByDefault = true;
    };
    difftastic.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      pull.ff = "only";
      merge = {
        conflictstyle = "zdiff3";
        tool = "meld";
      };
      push.default = "current";
      commit = {
        verbose = true;
        gpgsign = true;
      };
      rerere.enabled = true;
      core.pager = "bat";
      diff.algorithm = "histogram";
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
      transfer.fsckobjects = true;
      fetch.fsckobjects = true;
      receive.fsckObjects = true;
      branch.sort = "-committerdate";
    };

  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
