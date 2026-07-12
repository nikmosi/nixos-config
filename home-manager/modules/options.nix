{ lib, ... }:
{
  options.local = {
    cli = {
      atuin.enable = lib.mkEnableOption "atuin" // {
        default = true;
      };
      autostart.enable = lib.mkEnableOption "autostart" // {
        default = true;
      };
      bash.enable = lib.mkEnableOption "bash" // {
        default = true;
      };
      bat.enable = lib.mkEnableOption "bat" // {
        default = true;
      };
      broot.enable = lib.mkEnableOption "broot" // {
        default = true;
      };
      btop.enable = lib.mkEnableOption "btop" // {
        default = true;
      };
      carapace.enable = lib.mkEnableOption "carapace" // {
        default = true;
      };
      direnv.enable = lib.mkEnableOption "direnv" // {
        default = true;
      };
      docker.enable = lib.mkEnableOption "docker" // {
        default = true;
      };
      eza.enable = lib.mkEnableOption "eza" // {
        default = true;
      };
      fzf.enable = lib.mkEnableOption "fzf" // {
        default = true;
      };
      gh.enable = lib.mkEnableOption "gh" // {
        default = true;
      };
      git.enable = lib.mkEnableOption "git" // {
        default = true;
      };
      gpg.enable = lib.mkEnableOption "gpg" // {
        default = true;
      };
      lazygit.enable = lib.mkEnableOption "lazygit" // {
        default = true;
      };
      neofetch.enable = lib.mkEnableOption "neofetch" // {
        default = true;
      };
      neovim.enable = lib.mkEnableOption "neovim" // {
        default = true;
      };
      nushell.enable = lib.mkEnableOption "nushell" // {
        default = true;
      };
      pass.enable = lib.mkEnableOption "pass" // {
        default = true;
      };
      ranger.enable = lib.mkEnableOption "ranger" // {
        default = true;
      };
      ripgrep.enable = lib.mkEnableOption "ripgrep" // {
        default = true;
      };
      ssh.enable = lib.mkEnableOption "ssh" // {
        default = true;
      };
      starship.enable = lib.mkEnableOption "starship" // {
        default = true;
      };
      tar.enable = lib.mkEnableOption "tar" // {
        default = true;
      };
      television.enable = lib.mkEnableOption "television" // {
        default = true;
      };
      tmux.enable = lib.mkEnableOption "tmux" // {
        default = true;
      };
      uair.enable = lib.mkEnableOption "uair" // {
        default = true;
      };
      vale.enable = lib.mkEnableOption "vale" // {
        default = true;
      };
      yandex-disk.enable = lib.mkEnableOption "yandex-disk" // {
        default = true;
      };
      yazi.enable = lib.mkEnableOption "yazi" // {
        default = true;
      };
      yt-dlp.enable = lib.mkEnableOption "yt-dlp" // {
        default = true;
      };
      zed.enable = lib.mkEnableOption "zed" // {
        default = true;
      };
      zoxide.enable = lib.mkEnableOption "zoxide" // {
        default = true;
      };
    };
    desktop = {
      cliphist.enable = lib.mkEnableOption "cliphist" // {
        default = true;
      };
      desktop.enable = lib.mkEnableOption "desktop" // {
        default = true;
      };
      enhancer-for-youtube.enable = lib.mkEnableOption "enhancer-for-youtube" // {
        default = true;
      };
      mimeapps.enable = lib.mkEnableOption "mimeapps" // {
        default = true;
      };
      niri.enable = lib.mkEnableOption "niri" // {
        default = true;
      };
      noctalia.enable = lib.mkEnableOption "noctalia" // {
        default = true;
      };
      rofi.enable = lib.mkEnableOption "rofi" // {
        default = true;
      };
      rofi-pass.enable = lib.mkEnableOption "rofi-pass" // {
        default = true;
      };
      screenshot.enable = lib.mkEnableOption "screenshot" // {
        default = true;
      };
      stylix.enable = lib.mkEnableOption "stylix" // {
        default = true;
      };
    };
    apps = {
      kitty.enable = lib.mkEnableOption "kitty" // {
        default = true;
      };
      mpv.enable = lib.mkEnableOption "mpv" // {
        default = true;
      };
      zathura.enable = lib.mkEnableOption "zathura" // {
        default = true;
      };
    };
  };

  options.dotfiles = {
    gpgKey = lib.mkOption {
      type = lib.types.str;
      default = "B77DD388609E81892CBC2D6AB9CF67BBE64E1273";
      description = "Primary GPG key fingerprint for git signing.";
    };
    pamGnupgKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "7A66CC1C82953776FE2E80FBBE0C403B9C2E4485"
        "4CE6DA1AD68834E91CCB66E1386DEA05B047011F"
        "F0932A3122EAD7F16739035863EC63CD50ED3ACF"
        "C6C59CAFC8531B4B480183C89C8CFF61049A24F7"
      ];
      description = "GPG key fingerprints for PAM gnupg unlock.";
    };
    location = {
      latitude = lib.mkOption {
        type = lib.types.float;
        default = 55.0;
        description = "Latitude for location-based features.";
      };
      longitude = lib.mkOption {
        type = lib.types.float;
        default = 82.9;
        description = "Longitude for location-based features.";
      };
    };
  };
}
