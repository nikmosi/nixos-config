{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf (config.nik.display.backend == "wayland") {
  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  xdg.portal.config.niri."org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "greeter";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    grim
    slurp
    wl-clipboard
    swaybg
    wlr-randr
    brightnessctl
    gammastep
    lxqt.lxqt-policykit
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    XCURSOR_THEME = "Numix-Cursor-Light";
    XCURSOR_SIZE = "24";
  };
}
