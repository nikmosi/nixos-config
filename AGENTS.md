# AGENTS.md

Instructions for AI agents working with this NixOS flake configuration.

## Build Commands

```bash
# Build NixOS configuration (per-host)
nix build .#nixosConfigurations.nixos.config.system.build.toplevel
nix build .#nixosConfigurations.note-nixos.config.system.build.toplevel

# Build Home Manager configuration (per-host)
nix build .#homeConfigurations.nixos.activationPackage
nix build .#homeConfigurations.note-nixos.activationPackage

# Apply NixOS (auto-detects hostname)
nh os switch . -H $(hostname)

# Apply Home Manager
nh home switch . -c $(hostname)
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

- Per-host config: `hosts/<hostname>/` (default.nix, user.nix, hardware-configuration.nix, hardware.nix)
- Shared NixOS modules: `nixos/modules/`
- Shared Home Manager modules: `home-manager/modules/`
- All HM modules have `mkEnableOption` toggles in `home-manager/modules/options.nix`
- Catppuccin palette: `config.dotfiles.palette` (from `home-manager/modules/palette.nix`)
- Custom NixOS options: `nik.display.backend` (wayland|x11), `nik.hardware.gpu` (nvidia|amd|none), `nik.hardware.printer`, `nik.virtualization.*`, `nik.services.openssh.port`, `nik.services.endlessh.enable`
- Secrets: sops-nix with PGP key + age per-host, config in `.sops.yaml`

## Conventions

- Use `config.home.homeDirectory` not hardcoded `/home/nik`
- Use `config.xdg.configHome` not hardcoded `~/.config`
- Catppuccin colors: `config.dotfiles.palette.<color>` (hex string)
- Toggle modules: `config.local.<category>.<name>.enable`
- Nix formatter: nixfmt (RFC style)
- Lua formatter: stylua
