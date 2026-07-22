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

    # Neovim config development
    ripgrep
    fd
    lua-language-server
    pyright
    ruff
    yaml-language-server
    taplo
    hadolint
    stylua
    convco
  ];

  languages.nix.enable = true;

  # https://devenv.sh/scripts/
  scripts = {
    rebuild.exec = ''
      nh os switch . -H $(hostname)
    '';

    "rebuild-fallback".exec = ''
      sudo nixos-rebuild switch --flake .#$(hostname)
    '';

    home.exec = ''
      nh home switch . -c $(hostname) -b backup
    '';

    "home-fallback".exec = ''
      home-manager switch -b backup --flake .#$(hostname)
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

    # Lua (nvim config)
    stylua.enable = true;

    # General
    end-of-file-fixer.enable = true;
    trim-trailing-whitespace.enable = true;
    check-yaml.enable = true;
    fix-byte-order-marker.enable = true;
    check-added-large-files.enable = true;

    # Conventional commits
    convco.enable = true;

    trufflehog = {
      enable = true;
      stages = [ "pre-push" ];
    };
  };
}
