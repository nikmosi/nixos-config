{ pkgs, config, ... }:

{
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
}
