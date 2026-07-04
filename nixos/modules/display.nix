{ lib, ... }:
{
  options.nik.display = {
    backend = lib.mkOption {
      type = lib.types.enum [
        "wayland"
        "x11"
      ];
      default = "wayland";
      description = ''
        Display server backend to use.
        - "wayland": Niri compositor (default).
        - "x11": AwesomeWM + LightDM (legacy, used by the x11-awesome specialisation).
      '';
    };
  };
}
