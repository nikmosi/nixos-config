# Улучшение конфигурации niri + waybar

## Цель

Модернизировать конфигурацию niri и waybar в Nix flake на основе best practice из awesome-niri, awesome-waybar и niri wiki. Перейти от монолитного KDL-файла к декларативной Nix-конфигурации с build-time валидацией.

## Решения (из уточнения с пользователем)

- **Nix-модуль niri**: `niri-nix` (codeberg bananad3v) — freeform settings RFC 42, build-time `niri validate`.
- **Theming**: оставить hardcoded Tokyo Night для niri/waybar (stylix продолжает управлять шрифтами/курсором/иконками/gtk).
- **Лаунчер**: заменить rofi на anyrun (wayland-native, есть niri-focus plugin).
- **Уведомления**: заменить dunst на mako (wayland-native, лучше интеграция с layer-rule).
- **Объём**: полный (Этапы 1-5).

## Задачи

### Этап 1 — Nix-интеграция niri (валидация при сборке)

- [x] 1.1 Добавлен input `niri-nix` в `flake.nix` + импорт `homeModules.default` в homeConfigurations.
- [x] 1.2 `niri.nix` переведён с `xdg.configFile` на `wayland.windowManager.niri.settings` (freeform).
- [x] 1.3 `config.kdl` мигрирован в Nix-атрибуты (input, outputs, workspaces, layout, binds, window-rule, animations, spawn-at-startup).
- [x] 1.4 `niri/config.kdl` удалён после миграции.

### Этап 2 — niri: недостающие секции (best practice)

- [x] 2.1 `environment`: ELECTRON_OZONE_PLATFORM_HINT, XDG_CURRENT_DESKTOP, MOZ_ENABLE_WAYLAND, QT_QPA_PLATFORM, DISPLAY.
- [x] 2.2 `cursor`: xcursor-theme "Numix-Cursor-Light", xcursor-size 24, hide-when-typing.
- [x] 2.3 `hotkey-overlay`: skip-at-startup.
- [x] 2.4 `layer-rule`: waybar (place-within-backdrop), mako (block-out-from screencast).
- [x] 2.5 `clipboard`: primary оставлен; cliphist автонаполнение через spawn-sh-at-startup.
- [x] 2.6 `layout`: tab-indicator, struts, center-focused-column "on-overflow".
- [x] 2.7 `window-rule`: geometry-corner-radius 8 + clip-to-geometry, open-focused false для чатов.
- [x] 2.8 `animations`: per-spring (workspace-switch, window-open/close, horizontal-view-motion, window-movement, config-notification).
- [x] 2.9 `spawn-at-startup`: убран swaybg (awesome path), добавлен wl-paste --watch cliphist store.

### Этап 3 — niri binds: дополнить

- [x] 3.1 Mod+Shift+Slash { show-hotkey-overlay; } (каноничный).
- [x] 3.2 Mod+Shift+Tab { focus-window-previous; }.
- [x] 3.3 Mod+Alt+H/L { swap-window-left/right; }.
- [x] 3.4 Убран дубликат Mod+Alt+L (power-off-monitors оставлен на Mod+Shift+Ctrl+P).

### Этап 4 — waybar: модули и theming

- [x] 4.1 niri/workspaces: format "{icon} {windows}", window-rewrite (per-app иконки).
- [x] 4.2 niri/window: rewrite (чистка заголовков).
- [x] 4.3 memory built-in вместо custom/mem скрипта.
- [x] 4.4 keyboard-state (numlock/capslock).
- [x] 4.5 idle_inhibitor.
- [x] 4.6 network модуль.
- [x] 4.7 temperature модуль.
- [x] 4.8 clock: tooltip с календарём.
- [x] 4.9 custom/power меню (swaynag).
- [x] 4.10 custom/media (playerctl).
- [x] 4.11 CSS: #workspaces button.occupied, стили новых модулей.

### Этап 5 — Замена rofi/dunst на wayland-native

- [x] 5.1 Заменён rofi на anyrun (applications, symbols, rink, stdin, kidex, niri-focus).
- [x] 5.2 Обновлены binds niri (Mod+D → anyrun, Mod+C → anyrun clipboard, Mod+X → anyrun power).
- [x] 5.3 Обновлён screenshot.sh menu (rofi → anyrun stdin).
- [x] 5.4 Заменён dunst на mako (Tokyo Night тема).
- [x] 5.5 Удалены dunst.nix, rofi.nix, clipmenu.nix, redshift.nix; добавлены anyrun.nix, mako.nix.
- [x] 5.6 stylix.targets.mako.enable = false.

### Финал

- [x] F.1 `nix flake check` — all checks passed.
- [x] F.2 `statix check` — чисто. `deadnix` — чисто.
- [x] F.3 `nix build` — успешно (niri validate + anyrun плагины собраны).
- [x] F.4 PROGRESS.md обновлён.

## Прогресс

Начало: 2026-07-04. Завершено: 2026-07-06.

### Этап 1 — Nix-интеграция niri (валидация при сборке)

- [x] 1.1 Добавлен input `niri-nix` (codeberg bananad3v) в `flake.nix` + импорт `homeModules.default`.
- [x] 1.2 `niri.nix` переведён с `xdg.configFile` на `wayland.windowManager.niri.settings` (freeform RFC 42).
- [x] 1.3 `config.kdl` мигрирован в Nix-атрибуты (input, outputs, workspaces, layout, binds, window-rule, animations, environment, cursor, hotkey-overlay, layer-rule, spawn-at-startup).
- [x] 1.4 `niri/config.kdl` удалён. Build-time `niri validate` работает.

### Этап 2 — niri: недостающие секции

- [x] 2.1 `environment`: ELECTRON_OZONE_PLATFORM_HINT, XDG_CURRENT_DESKTOP, MOZ_ENABLE_WAYLAND, QT_QPA_PLATFORM, DISPLAY.
- [x] 2.2 `cursor`: xcursor-theme "Numix-Cursor-Light", xcursor-size 24, hide-when-typing.
- [x] 2.3 `hotkey-overlay`: skip-at-startup.
- [x] 2.4 `layer-rule`: waybar (place-within-backdrop), mako (block-out-from screencast).
- [x] 2.5 cliphist автонаполнение через spawn-sh-at-startup (wl-paste --watch cliphist store, text+image).
- [x] 2.6 `layout`: tab-indicator, struts, center-focused-column "on-overflow".
- [x] 2.7 `window-rule`: geometry-corner-radius 8 + clip-to-geometry, open-focused false для чатов.
- [x] 2.8 `animations`: per-spring (workspace-switch, window-open/close, horizontal-view-motion, window-movement, config-notification).
- [x] 2.9 `spawn-at-startup`: убран swaybg (awesome path), добавлен cliphist.

### Этап 3 — niri binds

- [x] 3.1 Mod+Shift+Slash { show-hotkey-overlay; }.
- [x] 3.2 Mod+Shift+Tab { focus-window-previous; }.
- [x] 3.3 Mod+Alt+H/L { swap-window-left/right; }.
- [x] 3.4 Убран дубликат Mod+Alt+L (power-off-monitors оставлен на Mod+Shift+Ctrl+P).

### Этап 4 — waybar

- [x] 4.1 niri/workspaces: format "{icon} {windows}", window-rewrite (per-app иконки).
- [x] 4.2 niri/window: rewrite (чистка заголовков firefox/chatterino/discord/telegram).
- [x] 4.3 memory built-in вместо custom/mem скрипта.
- [x] 4.4 keyboard-state (numlock/capslock).
- [x] 4.5 idle_inhibitor.
- [x] 4.6 network модуль.
- [x] 4.7 temperature модуль.
- [x] 4.8 clock: tooltip с календарём.
- [x] 4.9 custom/power меню (swaynag).
- [x] 4.10 custom/media (playerctl).
- [x] 4.11 CSS: #workspaces button.occupied, стили новых модулей (memory, temperature, network, idle_inhibitor, keyboard-state, custom-media, custom-power).

### Этап 5 — Замена rofi/dunst

- [x] 5.1 Заменён rofi на anyrun (applications, symbols, rink, stdin, kidex, niri-focus плагины).
- [x] 5.2 Обновлены binds niri (Mod+D → anyrun, Mod+C → anyrun clipboard, Mod+X → anyrun power).
- [x] 5.3 Обновлён screenshot.sh menu (rofi → anyrun stdin).
- [x] 5.4 Заменён dunst на mako (Tokyo Night тема, per-urgency цвета).
- [x] 5.5 Удалены dunst.nix, rofi.nix, clipmenu.nix (дублировал cliphist), redshift.nix (дублировал gammastep).
- [x] 5.6 stylix.targets.mako.enable = false (Tokyo Night hardcoded).

### Финал

- [x] F.1 `nix flake check` — all checks passed.
- [x] F.2 `statix check` — чисто.
- [x] F.3 `deadnix` — чисто.
- [x] F.4 `nix build .#homeConfigurations.nik.activationPackage` — успешно (niri validate + anyrun плагины собраны).

## Итог

Конфигурация niri переведена с монолитного KDL на декларативный Nix с build-time валидацией. Добавлены все недостающие секции niri (environment, cursor, hotkey-overlay, layer-rule, tab-indicator, struts, animations per-spring). Waybar расширен 7 новыми модулями. Rofi заменён на wayland-native anyrun, dunst — на mako. Удалён мёртвый код (clipmenu, redshift).