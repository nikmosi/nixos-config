{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf (config.nik.display.backend == "x11") {
  services.xserver.windowManager = {
    awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
        luadbi-mysql
        awesome-wm-widgets
      ];
    };
  };

  environment.sessionVariables.AWESOME_LIB = "${pkgs.awesome}/share/awesome/lib";
}
