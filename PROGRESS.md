# Улучшение конфигурации niri + desktop

## Цель

Модернизировать конфигурацию niri в Nix flake на основе best practice из awesome-niri и niri wiki. Перейти от монолитного KDL-файла к декларативной Nix-конфигурации с build-time валидацией. Унифицировать тему до Tokyo Night.

## Решения (из уточнения с пользователем)

- **Nix-модуль niri**: `niri-nix` (codeberg bananad3v) — freeform settings RFC 42, build-time `niri validate`.
- **Theming**: Tokyo Night hardcoded для niri/rofi; stylix → tokyo-night-dark; noctalia → builtin "Tokyo-Night".
- **Лаунчер**: rofi (остаётся).
- **Уведомления/bar/lock/nightlight**: noctalia (заменила waybar, mako, swaylock, gammastep — файлы удалены).
- **Объём**: полный (Этапы 1-5 + чистка).

## Задачи

### Этап 1 — Nix-интеграция niri (валидация при сборке)

- [x] 1.1 Добавлен input `niri-nix` в `flake.nix` + импорт `homeModules.default` в homeConfigurations.
- [x] 1.2 `niri.nix` переведён с `xdg.configFile` на `wayland.windowManager.niri.settings` (freeform).
- [x] 1.3 `config.kdl` мигрирован в Nix-атрибуты.
- [x] 1.4 `niri/config.kdl` удалён после миграции.

### Этап 2 — niri: недостающие секции (best practice)

- [x] 2.1 `environment`: ELECTRON_OZONE_PLATFORM_HINT, XDG_CURRENT_DESKTOP, MOZ_ENABLE_WAYLAND, QT_QPA_PLATFORM, DISPLAY.
- [x] 2.2 `cursor`: xcursor-theme "Numix-Cursor-Light", xcursor-size 24, hide-when-typing.
- [x] 2.3 `hotkey-overlay`: skip-at-startup.
- [x] 2.4 `layer-rule`: noctalia (place-within-backdrop, block-out-from screencast).
- [x] 2.5 `clipboard`: primary оставлен; cliphist автонаполнение через spawn-sh-at-startup.
- [x] 2.6 `layout`: tab-indicator, struts, center-focused-column "on-overflow".
- [x] 2.7 `window-rule`: geometry-corner-radius 8 + clip-to-geometry, open-focused false для чатов.
- [x] 2.8 `animations`: per-spring.
- [x] 2.9 `spawn-at-startup`: swaybg (per-output wallpaper), cliphist, autostart apps.

### Этап 3 — niri binds

- [x] 3.1 Mod+Shift+Slash { show-hotkey-overlay; }.
- [x] 3.2 Mod+Shift+Tab { focus-window-previous; }.
- [x] 3.3 Mod+Alt+H/L { swap-window-left/right; }.
- [x] 3.4 Убран дубликат Mod+Alt+L.

### Этап 4 — Чистка мёртвого кода и дубликатов

- [x] 4.1 Удалены мёртвые desktop-модули: waybar.nix, mako.nix, swaylock.nix, gammastep.nix (noctalia заменяет).
- [x] 4.2 Удалены мёртвые сервисы: fail2ban.nix (enable=false), caddy.nix (enable=false).
- [x] 4.3 Удалён nixos/modules/mime.nix (конфликт с home mimeapps.nix; yazi — каноничный).
- [x] 4.4 Удалён greenclip.nix (cliphist заменяет на Wayland).
- [x] 4.5 Удалён sioyek.nix (zathura заменяет).
- [x] 4.6 Удалены мёртвые скрипты: mem.sh, weather.sh из screenshot.nix (noctalia имеет weather widget).
- [x] 4.7 Убраны дублирующие пакеты из nixos/packages.nix (swaybg, grim, slurp, wl-clipboard, sops, fish, nushell, sshuttle, brightnessctl, wlr-randr — оставлены в home-manager).
- [x] 4.8 Убраны неиспользуемые системные пакеты: xclip, xsel, dnsmasq, xray, docker-buildx, pulseaudioFull, qjackctl.
- [x] 4.9 Убраны неиспользуемые home-пакеты: fuzzel, swayidle, maim, feh, sioyek, weave-gitops, blanket, lmstudio.

### Этап 5 — Системные модули: правки

- [x] 5.1 users.nix: убран `programs.xonsh.enable` (не используется).
- [x] 5.2 programs.nix: убран `command-not-found.enable` (оставлен nix-index).
- [x] 5.3 programs.nix: убран системный `programs.firefox.enable` (home-manager управляет).
- [x] 5.4 programs.nix: убраны fish null-aliases (l, ll, ls).
- [x] 5.5 security.nix: убран `pam.services.swaylock` (noctalia lockscreen).
- [x] 5.6 hardware-configuration.nix: исправлена опечатка `nvidia_modsetf` → `nvidia_modeset`.
- [x] 5.7 nushell.nix: убран `alias x = xonsh`.

### Этап 6 — SOPS: унификация

- [x] 6.1 `defaultSopsFile` объявлен один раз в `envs.nix` (убран из ssh_keys.nix и flux.nix).
- [x] 6.2 `gnupg.home` объявлен один раз в `envs.nix`.
- [x] 6.3 Секрет `api_keys/timeweb/terraform_api_key` перенесён в `${configDir}/terraform/.envrc` (вместо /home/nik/git-repos/DO11/...).

### Этап 7 — Тема: Tokyo Night везде

- [x] 7.1 stylix: `base16Scheme` → `tokyo-night-dark.yaml` (вместо catppuccin-macchiato).
- [x] 7.2 noctalia: `theme.builtin` → "Tokyo-Night" (вместо Catppuccin).
- [x] 7.3 niri.nix, rofi.nix: уже Tokyo Night hardcoded — без изменений.

### Финал

- [x] F.1 `nix flake check` — all checks passed.
- [x] F.2 `statix check` — чисто. `deadnix` — чисто.
- [x] F.3 `nix build` — успешно.
- [x] F.4 PROGRESS.md обновлён.

## Прогресс

Начало: 2026-07-04. Чистка: 2026-07-11.

## Итог

Конфигурация niri переведена с монолитного KDL на декларативный Nix с build-time валидацией. Noctalia полностью заменяет waybar/mako/swaylock/gammastep (мёртвые файлы удалены). Тема унифицирована до Tokyo Night (stylix + noctalia + niri/rofi hardcoded). Удалён мёртвый код (fail2ban, caddy, greenclip, sioyek, mime.nix, мёртвые скрипты). Убраны дублирующие и неиспользуемые пакеты. SOPS унифицирован. Исправлена опечатка в nvidia kernel module.