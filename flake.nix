{
  description = "My NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    unstable-nix.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ayugram-desktop = {
      type = "git";
      submodules = true;
      url = "https://github.com/ndfined-crp/ayugram-desktop/";
      rev = "fa30f75525da0074d1cefaaaca40dcd8c6b4746e";
    };

    stylix.url = "github:danth/stylix/release-25.11";

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
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
          defaultSystem = "x86_64-linux";

          unstablePkgs = import inputs."unstable-nix" {
            system = defaultSystem;
          };
        in
        {
          nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
              system = defaultSystem;
              specialArgs = {
                inherit inputs;
                unstable = unstablePkgs;
              };
              modules = [
                ./nixos/configuration.nix
              ];
            };
          };

          homeConfigurations = {
            nik = home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.${defaultSystem};
              modules = [
                # { home-manager.backupFileExtension = "backup"; }
                ./home-manager/home.nix
              ];
              extraSpecialArgs = {
                inherit inputs;
                unstable = unstablePkgs;
                telegrams = inputs."ayugram-desktop";
              };
            };
          };
        };
    };
}
