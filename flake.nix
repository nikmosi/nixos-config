{
  description = "nikmosi's nixos configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    unstable-nix.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    ayugram-desktop = {
      type = "git";
      submodules = true;
      url = "https://github.com/ndfined-crp/ayugram-desktop/";
    };

    stylix.url = "github:danth/stylix/release-25.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    sing-box-extended = {
      url = "git+file:///home/nik/git-repos/sing-box-extended";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      flake-parts,
      home-manager,
      pre-commit-hooks,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      # All systems that will get perSystem outputs (devShells, checks, etc.)
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem =
        {
          system,
          pkgs,
          config,
          ...
        }:
        {
          # `nix fmt`
          formatter = pkgs.nixfmt-rfc-style;

          # `nix flake check` → run pre-commit hooks
          checks.pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixfmt-rfc-style.enable = true;
            };
          };

          # `nix develop` → dev shell with hooks + nushell
          devShells.default = pkgs.mkShell {
            name = "conf";

            # Packages required by enabled hooks
            packages = config.checks.pre-commit-check.enabledPackages;

            shellHook = ''
              ${config.checks.pre-commit-check.shellHook}
              exec nu
            '';
          };
        };

      flake =
        let
          # Global configuration settings
          userSettings = {
            username = "nik";
            system = "x86_64-linux";
            hostname = "nixos";
          };

          unstablePkgs = import inputs."unstable-nix" {
            system = userSettings.system;
            config.allowUnfree = true;
          };
        in
        {
          nixosConfigurations = {
            "${userSettings.hostname}" = nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs;
                unstable = unstablePkgs;
                inherit userSettings;
              };
              modules = [
                ./nixos/configuration.nix
                inputs.sops-nix.nixosModules.sops
                {
                  nixpkgs.hostPlatform = userSettings.system;
                  nixpkgs.overlays = [
                    inputs.nur.overlays.default
                    inputs.sing-box-extended.overlays.default
                  ];
                }
              ];
            };
          };

          homeConfigurations = {
            "${userSettings.username}" = home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.${userSettings.system};
              modules = [
                # { home-manager.backupFileExtension = "backup"; }
                inputs.sops-nix.homeManagerModules.sops
                ./home-manager/home.nix
              ];
              extraSpecialArgs = {
                inherit inputs;
                unstable = unstablePkgs;
                telegrams = inputs."ayugram-desktop";
                inherit userSettings;
              };
            };
          };
        };
    };
}
