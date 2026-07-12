# AGENTS.md

Instructions for AI agents working with this NixOS flake configuration.

## Build Commands

```bash
# Build NixOS configuration
nix build .#nixosConfigurations.nixos.config.system.build.toplevel

# Build Home Manager configuration
nix build .#homeConfigurations.nik.activationPackage

# Apply NixOS
nh os switch . -H nixos

# Apply Home Manager
nh home switch . -c nik
```

## Lint & Format

```bash
# Format all code
nix fmt

# Check Nix linting
statix check .
deadnix -c .

# Flake check
nix flake check
```

## Structure

- NixOS modules: `nixos/modules/`
- Home Manager modules: `home-manager/modules/`
- All HM modules have `mkEnableOption` toggles in `home-manager/modules/options.nix`
- Catppuccin palette: `config.dotfiles.palette` (from `home-manager/modules/palette.nix`)
- Custom NixOS options: `nik.display.backend` (wayland|x11)
- Secrets: sops-nix with PGP key, config in `.sops.yaml`

## Conventions

- Use `config.home.homeDirectory` not hardcoded `/home/nik`
- Use `config.xdg.configHome` not hardcoded `~/.config`
- Catppuccin colors: `config.dotfiles.palette.<color>` (hex string)
- Toggle modules: `config.local.<category>.<name>.enable`
- Nix formatter: nixfmt (RFC style)
- Lua formatter: stylua
