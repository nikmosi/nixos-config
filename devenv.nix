{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  env.FLAKE_NAME = "nikmosi's nixos configuration";

  # Useful packages for a NixOS/Home-Manager flake
  packages = with pkgs; [
    git
    age
    sops
    statix
    deadnix
    nix-output-monitor
  ];

  languages.nix.enable = true;

  # https://devenv.sh/scripts/
  scripts = {
    rebuild.exec = ''
      sudo nixos-rebuild switch --flake .#nixos
    '';

    home.exec = ''
      home-manager switch --flake .#nik
    '';

    update.exec = ''
      nix flake update
    '';

    check-flake.exec = ''
      nix flake check
    '';
  };

  # https://devenv.sh/basics/
  enterShell = ''
    echo "Welcome to ''${FLAKE_NAME} dev environment!"
    echo "Available commands:"
    echo "  rebuild      - Switch NixOS configuration"
    echo "  home         - Switch Home Manager configuration"
    echo "  update       - Update flake inputs"
    echo "  check-flake  - Run flake checks"
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running statix check"
    statix check .
    echo "Running deadnix check"
    deadnix -c .
  '';

  # Configure git hooks
  git-hooks.hooks = {
    # Format Nix code
    nixfmt.enable = true;

    # Lint Nix code
    statix.enable = true;
    deadnix.enable = true;
  };
}
