{
  imports = [
    ./wms/awesome.nix
    ./dms/lightdm.nix
  ];

  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb.layout = "us";
  };
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
}
