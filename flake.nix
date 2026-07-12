{
  description = "nikmosi's nixos configuration.";

  inputs = {
    stable.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs.follows = "stable";

    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "stable";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "stable";

    ayugram-desktop = {
      type = "git";
      submodules = true;
      url = "https://github.com/ndfined-crp/ayugram-desktop/";
    };

    stylix.url = "github:danth/stylix/release-26.05";
    stylix.inputs.nixpkgs.follows = "stable";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "stable";

    niri-nix = {
      url = "git+https://codeberg.org/bananad3v/niri-nix";
      inputs.nixpkgs.follows = "stable";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "stable";

    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "stable";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "stable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixos-hardware.inputs.nixpkgs.follows = "stable";
  };

  outputs =
    inputs@{
      stable,
      flake-parts,
      home-manager,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.treefmt-nix.flakeModule ];

      # All systems that will get perSystem outputs (devShells, checks, etc.)
      systems = stable.lib.systems.flakeExposed;

      perSystem = _: {
        treefmt = {
          projectRootFile = "flake.nix";
          programs = {
            nixfmt.enable = true;
            deadnix.enable = true;
            statix.enable = true;
            stylua.enable = true;
            prettier.enable = true;
          };
          settings.formatter = {
            deadnix.priority = 1;
            statix.priority = 2;
            nixfmt.priority = 3;
          };
        };
      };

      flake =
        let
          # Overlay to expose unstable packages via pkgs.unstable
          unstableOverlay = final: _: {
            unstable = import inputs.unstable {
              system = final.stdenv.hostPlatform.system;
              config.allowUnfree = true;
            };
          };

          # Load host-specific settings
          hostConfig = import ./hosts/nixos/default.nix;
          userSettings = import ./hosts/nixos/user.nix;
        in
        {
          nixosConfigurations = {
            "${userSettings.hostname}" = stable.lib.nixosSystem {
              specialArgs = {
                inherit inputs;
                inherit userSettings;
              };
              modules = [
                ./nixos/configuration.nix
                inputs.sops-nix.nixosModules.sops
                inputs.nixos-hardware.nixosModules.common-cpu-intel
                inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
                inputs.nixos-hardware.nixosModules.common-pc-ssd
                hostConfig
                {
                  nixpkgs.hostPlatform = userSettings.system;
                  nixpkgs.overlays = [
                    inputs.nur.overlays.default
                    unstableOverlay
                  ];
                  nix.nixPath = [
                    "nixpkgs=${inputs.stable}"
                    "unstable=${inputs.unstable}"
                  ];
                }
              ];
            };
          };

          homeConfigurations = {
            "${userSettings.username}" = home-manager.lib.homeManagerConfiguration {
              pkgs = stable.legacyPackages.${userSettings.system}.extend (
                stable.lib.composeManyExtensions [
                  inputs.nur.overlays.default
                  unstableOverlay
                ]
              );
              modules = [
                # { home-manager.backupFileExtension = "backup"; }
                inputs.sops-nix.homeManagerModules.sops
                inputs.niri-nix.homeModules.default
                inputs.catppuccin.homeModules.catppuccin
                ./home-manager/home.nix
              ];
              extraSpecialArgs = {
                inherit inputs;
                telegrams = inputs."ayugram-desktop";
                inherit userSettings;
                inherit hostConfig;
              };
            };
          };
        };
    };
}
