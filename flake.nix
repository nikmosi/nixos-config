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

          # Hosts to generate configurations for
          hostNames = [
            "nixos"
            "note-nixos"
          ];

          # Build a NixOS configuration for a single host
          mkNixos =
            name:
            let
              userSettings = import ./hosts/${name}/user.nix;
              hostConfig = import ./hosts/${name}/default.nix;
            in
            stable.lib.nixosSystem {
              specialArgs = {
                inherit inputs userSettings hostConfig;
              };
              modules = [
                ./nixos/configuration.nix
                ./hosts/${name}/hardware-configuration.nix
                ./hosts/${name}/hardware.nix
                inputs.sops-nix.nixosModules.sops
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

          # Build a Home Manager configuration for a single host
          mkHome =
            name:
            let
              userSettings = import ./hosts/${name}/user.nix;
              hostConfig = import ./hosts/${name}/default.nix;
            in
            home-manager.lib.homeManagerConfiguration {
              pkgs = stable.legacyPackages.${userSettings.system}.extend (
                stable.lib.composeManyExtensions [
                  inputs.nur.overlays.default
                  unstableOverlay
                ]
              );
              modules = [
                inputs.sops-nix.homeManagerModules.sops
                inputs.niri-nix.homeModules.default
                inputs.catppuccin.homeModules.catppuccin
                ./home-manager/home.nix
              ];
              extraSpecialArgs = {
                inherit inputs;
                telegrams = inputs."ayugram-desktop";
                inherit userSettings hostConfig;
              };
            };
        in
        {
          nixosConfigurations = stable.lib.genAttrs hostNames mkNixos;
          homeConfigurations = stable.lib.genAttrs hostNames mkHome;
        };
    };
}
