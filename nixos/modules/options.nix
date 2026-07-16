{ lib, ... }:
{
  options.nik = {
    display.backend = lib.mkOption {
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

    hardware = {
      gpu = lib.mkOption {
        type = lib.types.enum [
          "nvidia"
          "amd"
          "none"
        ];
        default = "none";
        description = "GPU vendor for hardware-specific configuration.";
      };
      printer = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable printer drivers (hplip, gutenprint, cups).";
      };
    };

    virtualization = {
      docker.storageDriver = lib.mkOption {
        type = lib.types.str;
        default = "btrfs";
        description = "Docker storage driver.";
      };
      virtualbox.enable = lib.mkEnableOption "VirtualBox host" // {
        default = true;
      };
    };

    services = {
      endlessh.enable = lib.mkEnableOption "endlessh tarpit" // {
        default = true;
      };
      openssh.port = lib.mkOption {
        type = lib.types.port;
        default = 22000;
        description = "SSH daemon port.";
      };
    };

    user.gpgKey = lib.mkOption {
      type = lib.types.str;
      default = "B77DD388609E81892CBC2D6AB9CF67BBE64E1273";
      description = "Primary GPG key fingerprint for git signing and sops.";
    };

    user.pamGnupgKeys = lib.mkOption {
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
        description = "Latitude for location-based features (night light, weather).";
      };
      longitude = lib.mkOption {
        type = lib.types.float;
        default = 82.9;
        description = "Longitude for location-based features (night light, weather).";
      };
    };

    networking = {
      uplinkInterface = lib.mkOption {
        type = lib.types.str;
        default = "eno1";
        description = "Primary network interface for uplink.";
      };
      extraHosts = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Extra entries for /etc/hosts.";
      };
    };

    docker.dns = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "8.8.8.8"
        "1.1.1.1"
      ];
      description = "DNS servers for Docker daemon.";
    };

    monitors = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
      description = ''
        Monitor configuration: name, mode, position, wallpaper.
        Optional per-monitor fields:
        - vrr (bool, default true): enable variable-refresh-rate on this output.
      '';
    };
  };
}
