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
    nh
  ];

  languages.nix.enable = true;

  # https://devenv.sh/scripts/
  scripts = {
    rebuild.exec = ''
      nh os switch . -H nixos
    '';

    "rebuild-fallback".exec = ''
      sudo nixos-rebuild switch --flake .#nixos
    '';

    home.exec = ''
      nh home switch . -c nik
    '';

    "home-fallback".exec = ''
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
    echo "  rebuild          - Switch NixOS configuration (via nh)"
    echo "  rebuild-fallback - Switch NixOS configuration (via nixos-rebuild)"
    echo "  home             - Switch Home Manager configuration (via nh)"
    echo "  home-fallback    - Switch Home Manager configuration (via home-manager)"
    echo "  update           - Update flake inputs"
    echo "  check-flake      - Run flake checks"
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
