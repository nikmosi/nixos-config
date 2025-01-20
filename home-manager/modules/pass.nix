{ pkgs, config, ... }:
let
  store_dir = "${config.xdg.dataHome}/.password-store";
in
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
      PASSWORD_STORE_DIR = store_dir;
    };
  };
  programs.rofi.pass = {
    enable = true;
    stores = [ store_dir ];
  };
}
