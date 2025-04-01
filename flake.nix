{
  description = "My NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    unstable-nix.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ayugram-desktop.url = "github:/ayugram-port/ayugram-desktop/release?submodules=1";
    stylix.url = "github:danth/stylix/release-24.11";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ayugram-desktop,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      unstable = import inputs.unstable-nix {
        system = system;
      };
      pkgs = import nixpkgs {
        system = system;
      };
      qtileDeps = import ./qtile-deps.nix { inherit pkgs; };
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      checks = forAllSystems (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixfmt-rfc-style.enable = true;

          };
        };
      });

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          name = "conf";
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
          shellHook = ''
            ${self.checks.${system}.pre-commit-check.shellHook}
            exec nu
          '';

        };
      });
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs qtileDeps;
          };
          modules = [
            ./nixos/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        nik = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home-manager/home.nix
          ];
          extraSpecialArgs = {
            inherit inputs unstable;
            telegrams = ayugram-desktop;
          };
        };
      };
    };
}
