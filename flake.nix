{
  description = "My NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable-nix.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ayugram-desktop.url = "github:/ayugram-port/ayugram-desktop/release?submodules=1";
    stylix.url = "github:danth/stylix/release-25.05";
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
      unstable = inputs.unstable-nix.legacyPackages.${system};
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
          specialArgs = { inherit inputs unstable; };
          modules = [ ./nixos/configuration.nix ];
        };
      };

      homeConfigurations = {
        home-manager.backupFileExtension = "backup";
        nik = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./home-manager/home.nix ];
          extraSpecialArgs = {
            inherit inputs unstable;
            telegrams = ayugram-desktop;
          };
        };
      };
    };
}
