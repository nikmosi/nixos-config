# nikmosi's NixOS Configuration

NixOS + Home Manager flake configuration for multiple hosts (desktop + laptop).

## Hosts

| Host         | Hardware                          | Role    |
| ------------ | --------------------------------- | ------- |
| `nixos`      | Intel + NVIDIA, 2 monitors, btrfs | Desktop |
| `note-nixos` | AMD Ryzen 3500U, 1 monitor, ext4  | Laptop  |

## Structure

```
flake.nix           — flake entry (flake-parts, multi-host)
devenv.nix          — dev shell (formatters, linters, scripts)
hosts/              — per-host configuration
  nixos/            — desktop host
    default.nix     — monitors, networking, GPU, location
    user.nix        — username, hostname, stateVersion
    hardware-configuration.nix — generated hardware config
    hardware.nix    — nixos-hardware modules (Intel, NVIDIA, SSD)
  note-nixos/       — laptop host
    ...             — same structure
nixos/              — shared NixOS system configuration
  configuration.nix — system entry
  packages.nix      — system packages
  modules/          — NixOS modules (audio, boot, networking, etc.)
home-manager/       — shared Home Manager user configuration
  home.nix          — HM entry
  packages.nix      — user packages
  modules/          — HM modules
    options.nix     — mkEnableOption toggles for all modules
    dotfiles.nix    — dotfiles.path option (for out-of-store symlinks)
    palette.nix     — Catppuccin palette from catppuccin/nix
    cli/            — CLI tool configs (git, nushell, neovim, etc.)
    desktop/        — desktop configs (niri, rofi, stylix, etc.)
    apps/           — GUI apps (kitty, mpv, zathura)
assets/             — wallpapers, rofi themes
secrets/            — sops-encrypted secrets (PGP + age)
```

## Commands

```bash
# Enter dev shell (auto via direnv)
cd ~/.flake

# Rebuild NixOS (auto-detects hostname)
nh os switch . -H $(hostname)
# or: sudo nixos-rebuild switch --flake .#$(hostname)

# Rebuild Home Manager
nh home switch . -c $(hostname)
# or: home-manager switch --flake .#$(hostname)

# Update flake inputs
nix flake update

# Format code
nix fmt

# Check flake
nix flake check

# Edit secrets
sops secrets/personal.yaml
```

## Key Features

- **Catppuccin Macchiato** theme via catppuccin/nix (single source of truth)
- **Niri** Wayland compositor with X11/Awesome specialisation fallback
- **sops-nix** secrets management (PGP key)
- **mkEnableOption** toggles for all HM modules (`local.cli.*.enable`, `local.desktop.*.enable`, `local.apps.*.enable`)
- **Out-of-store symlink** for neovim config (edit .lua without rebuild)
- **treefmt-nix** for formatting (nixfmt, deadnix, statix, stylua, prettier)
- **NUR** overlay for both NixOS and Home Manager

## Flake Inputs

| Input        | Purpose                      |
| ------------ | ---------------------------- |
| stable       | NixOS 26.05                  |
| unstable     | nixos-unstable (via overlay) |
| home-manager | User environment management  |
| sops-nix     | Secrets management           |
| stylix       | System theming               |
| catppuccin   | Color palette                |
| nur          | Nix User Repository          |
| niri-nix     | Niri compositor module       |
| noctalia     | Desktop shell                |
| flake-parts  | Flake structure              |
| treefmt-nix  | Code formatting              |
