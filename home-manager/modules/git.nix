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
