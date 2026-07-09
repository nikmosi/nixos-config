{
  description = "nikmosi's nixos configuration.";

  inputs = {
    stable.url = "github:NixOS/nixpkgs/nixos-26.05";

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

    # sing-box-extended = {
    #   url = "git+file:///home/nik/git-repos/sing-box-extended";
    #   inputs.nixpkgs.follows = "stable";
    # };
  };

  outputs =
    inputs@{
      stable,
      flake-parts,
      home-manager,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      # All systems that will get perSystem outputs (devShells, checks, etc.)
      systems = stable.lib.systems.flakeExposed;

      flake =
        let
          # Global configuration settings
          userSettings = {
            username = "nik";
            system = "x86_64-linux";
            hostname = "nixos";
            systemStateVersion = "25.05";
            homeStateVersion = "25.05";
          };

          # Overlay to expose unstable packages via pkgs.unstable
          unstableOverlay = final: _: {
            unstable = import inputs.unstable {
              system = final.stdenv.hostPlatform.system;
              config.allowUnfree = true;
            };
          };
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
                {
                  nixpkgs.hostPlatform = userSettings.system;
                  nixpkgs.overlays = [
                    inputs.nur.overlays.default
                    unstableOverlay
                    # inputs.sing-box-extended.overlays.default
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
              pkgs = stable.legacyPackages.${userSettings.system}.extend unstableOverlay;
              modules = [
                # { home-manager.backupFileExtension = "backup"; }
                inputs.sops-nix.homeManagerModules.sops
                inputs.niri-nix.homeModules.default
                ./home-manager/home.nix
              ];
              extraSpecialArgs = {
                inherit inputs;
                telegrams = inputs."ayugram-desktop";
                inherit userSettings;
              };
            };
          };
        };
    };
}
