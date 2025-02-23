{
  description = "My NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ayugram-desktop.url = "github:/ayugram-port/ayugram-desktop/release?submodules=1";
    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ayugram-desktop,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = system;
      };
      qtileDeps = import ./qtile-deps.nix { inherit pkgs; };
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs qtileDeps; };
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
            inherit inputs;
            telegrams = ayugram-desktop;
          };
        };
      };
    };
}
