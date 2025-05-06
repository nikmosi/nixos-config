{ config, ... }:
{
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
      "color \"advice\"" = {
        autoDetect = "#56b6c2";
        ambiguousArgument = "#e06c75";
      };
      "color \"blame\"" = {
        author = "#98c379";
        authorDate = "#e5c07b";
        summary = "#d19a66";
      };
      "color \"decorate\"" = {
        branch = "#61afef";
        tag = "#c678dd";
        stash = "#e06c75";
      };
      "color \"diff\"" = {
        meta = "#e5c07b";
        frag = "#56b6c2";
        old = "#e06c75";
        new = "#98c379";
      };
      "color \"interactive\"" = {
        prompt = "#98c379";
        response = "#e5c07b";
      };
      "color \"push\"" = {
        remote = "#e06c75";
      };
      "color \"remote\"" = {
        url = "#56b6c2";
        status = "#61afef";
      };
      "color \"showBranch\"" = {
        current = "#98c379";
        other = "#c678dd";
      };
      "color \"transport\"" = {
        send = "#e06c75";
        receive = "#98c379";
      };
      "color \"ui\"" = {
        normal = "#abb2bf";
        error = "#e06c75";
        success = "#98c379";
      };
      "color \"status\"" = {
        added = "#98c379";
        staged = "#56b6c2";
        changed = "#e5c07b";
        untracked = "#61afef";
        deleted = "#e06c75";
        renamed = "#c678dd";
        updated = "#d19a66";
        localBranch = "#c678dd";
        branch = "#61afef";
        remoteBranch = "#e06c75";
      };
      "color \"branch\"" = {
        current = "#98c379";
        local = "#c678dd";
        remote = "#d19a66";
      };
      lfs.repositoryformatversion = 0;
      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };
      git-extras.get.clone-path = "${config.home.homeDirectory}/git-repos";
      init.defaultBranch = "main";
      pull.ff = "only";
      merge = {
        conflictstyle = "zdiff3";
        tool = "meld";
        ff = "only";
      };
      push.default = "current";
      commit = {
        verbose = true;
        gpgsign = true;
      };
      rerere.enabled = true;
      rebase.updateRefs = true;
      core.pager = "bat";
      diff.algorithm = "histogram";
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
      transfer.fsckobjects = true;
      fetch.fsckobjects = true;
      fetch.writeCommitGraph = true;
      receive.fsckObjects = true;
      branch.sort = "-committerdate";
    };

  };
}
