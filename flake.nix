{
  description = "My NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = system; };
      qtileDeps =
        with pkgs.python312Packages;
        [
          qtile-extras
          dateutils
          python-dotenv
          loguru
          requests
          yarl
          pydantic
          pydantic-settings
        ];
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs.python312Packages; [
          qtile
          python
        ] ++ qtileDeps;
      };
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit qtileDeps;};
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
        };
      };
    };
}
