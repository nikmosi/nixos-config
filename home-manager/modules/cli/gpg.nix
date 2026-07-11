{
  pkgs,
  ...
}:
let
  # ── pinentry-rofi wrapper ─────────────────────────────────────────
  # Uses a dedicated "Vault" .rasi theme (Catppuccin Macchiato, purple accent)
  # with bright cyan entry text so password • dots are clearly visible.
  # Args after `--` are forwarded to rofi by pinentry-rofi (see its --help).
  pinentry-rofi-themed = pkgs.writeShellScriptBin "pinentry-rofi-themed" ''
    exec ${pkgs.pinentry-rofi}/bin/pinentry-rofi -- \
      -theme ${../../../assets/rofi-pinentry.rasi}
  '';

  # ── pinentry dispatcher ───────────────────────────────────────────
  # Reads PINENTRY_USER_DATA env var (set via gpg-connect-agent) to choose backend:
  #   gpg-connect-agent "OPTION pinentry-user-data=qt"   /bye
  #   gpg-connect-agent "OPTION pinentry-user-data=tty"  /bye
  #   gpg-connect-agent "OPTION pinentry-user-data=rofi" /bye
  # Empty/unset → rofi (default). No gpg-agent restart needed.
  # Note: OPTION uses hyphens; gpg-agent passes it as PINENTRY_USER_DATA env var.
  pinentry-dispatch = pkgs.writeShellScriptBin "pinentry-dispatch" ''
    case "''${PINENTRY_USER_DATA:-}" in
      qt|pinentry-qt)         exec ${pkgs.pinentry-qt}/bin/pinentry-qt "$@" ;;
      tty|pinentry-tty)       exec ${pkgs.pinentry-tty}/bin/pinentry-tty "$@" ;;
      curses|pinentry-curses) exec ${pkgs.pinentry-curses}/bin/pinentry-curses "$@" ;;
      rofi|pinentry-rofi|"")  exec ${pinentry-rofi-themed}/bin/pinentry-rofi-themed "$@" ;;
      *)                      exec ${pinentry-rofi-themed}/bin/pinentry-rofi-themed "$@" ;;
    esac
  '';
in
{
  programs.gpg = {
    enable = true;
    settings = {
      keyid-format = "long";
    };
  };
  services.ssh-agent.enable = false;

  services.gpg-agent = {
    enable = true;

    enableSshSupport = true;

    defaultCacheTtl = 7200;
    maxCacheTtl = 86400;

    pinentry.package = pinentry-dispatch;
    pinentry.program = "pinentry-dispatch";

    extraConfig = ''
      allow-preset-passphrase
    '';
  };

  home.file.".pam-gnupg".text = ''
    7A66CC1C82953776FE2E80FBBE0C403B9C2E4485
    4CE6DA1AD68834E91CCB66E1386DEA05B047011F
    F0932A3122EAD7F16739035863EC63CD50ED3ACF
    C6C59CAFC8531B4B480183C89C8CFF61049A24F7
  '';
}
