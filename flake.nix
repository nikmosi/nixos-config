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
      lib = nixpkgs.lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = lib.genAttrs systems;

      defaultSystem = "x86_64-linux";
      unstable = import inputs.unstable-nix { system = defaultSystem; };

      commonModules = [
        ./nixos/modules/default.nix
        ./nixos/nixos-packages.nix
        ./nixos/hardware-configuration.nix
      ];

      hostModules = {
        laptop = ./nixos/hosts/laptop.nix;
        desktop = ./nixos/hosts/desktop.nix;
      };

      mkHost = host:
        lib.nixosSystem {
          system = defaultSystem;
          specialArgs = {
            inherit inputs unstable;
          };
          modules = commonModules ++ [ hostModules.${host} ];
        };

      # Фолбэк для `.#system`: значение переменной окружения считывается
      # на этапе оценки flake, поэтому её нужно экспортировать заранее.
      mkHostFromEnv =
        let
          rawHost = builtins.getEnv "NIXOS_HOST_TYPE";
          hostKey =
            if rawHost == "" then
              throw ''Переменная NIXOS_HOST_TYPE не задана. Экспортируйте "laptop" или "desktop" перед вызовом `.#system`.''
            else
              lib.strings.toLower rawHost;
        in
        if builtins.hasAttr hostKey hostModules then
          mkHost hostKey
        else
          throw ''Неизвестный тип хоста "${hostKey}". Допустимы: ${lib.concatStringsSep ", " (builtins.attrNames hostModules)}.'';
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
        laptop = mkHost "laptop";
        desktop = mkHost "desktop";
        system = mkHostFromEnv;
      };

      homeConfigurations = {
        nik = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${defaultSystem};
          modules = [ ./home-manager/home.nix ];
          extraSpecialArgs = {
            inherit inputs unstable;
            telegrams = ayugram-desktop;
          };
        };
      };
    };
}
