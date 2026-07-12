Анализ конфигурации ~/.flake
Масштаб: 87 .nix файлов, ~6,500 LOC + 87 lua-файлов nvim. 10 flake inputs, 12 sops secrets, 2 кастомных опции, 0 CI, 0 тестов, 0 кастомных пакетов.

1. Баги и ошибки (критично)

# Проблема Файл:строка Исправление

1 fish.nix не импортирован в cli/default.nix — 212 строк мёртвого кода, 56 алиасов, fzf/bass плагины не работают cli/default.nix Добавить ./fish.nix в imports
2 fish.nix builtins.fetchGit revs фейковые — c2f3a0b6c940735c5df8f6f2c2c7e6f5a1c2b3d4 выглядит сгенерированным, не настоящий SHA fish.nix:7,12 Заменить на реальные rev из GitHub
3 atuin.nix @atuin_key@ — литерал вместо sops placeholder ${config.sops.placeholder.atuin_key} atuin.nix:41 Использовать sops placeholder
4 enhancer-for-youtube.nix — имя файла enchancer_for_youtuve.json (опечатки "enchancer" + "youtuve") enhancer-for-youtube.nix:2 Исправить имя файла
5 git.nix url.insteadOf — 4 правила мапят https→https (no-ops) git.nix:113-124 Либо удалить, либо указать правильные source/target
6 nix-ld.nix — gnutls, libGL, libx11 дублируются в списке libraries nix-ld.nix:10-13,47-52 Удалить дубликаты
7 bat.nix — file = "gruvbox (Dark) (Medium)..." но theme key dracula — несоответствие bat.nix Проверить соответствие file↔theme
8 mpv.nix — builtins.fetchurl с sha256: префиксом — может не работать mpv.nix:94-97 Проверить, убрать префикс если нужно 2. Архитектура — точки роста
2.1. Единый источник темы (Catppuccin palette)
Проблема: Палитра Catppuccin Macchiato хардкожена 4 раза: niri.nix:4-16, rofi.nix:41-53, noctalia.nix:7-16, kitty.nix themeFile. При этом stylix.nix:21 уже задаёт base16Scheme — но он игнорируется.
Решение: Использовать catppuccin/nix (750 stars) или base16.nix как единственный источник. Stylix уже подключён — нужно убрать inline-палитры и использовать config.lib.stylix.colors в niri/rofi/noctalia.
2.2. mkEnableOption для всех HM-модулей
Проблема: Ни один HM-модуль не имеет mkEnableOption. Чтобы отключить television.nix, нужно редактировать default.nix. Это не идиоматично для home-manager.
Решение: Каждый модуль должен начинаться с:
{ lib, ... }: {
options.local.cli.television.enable = lib.mkEnableOption "television";
config = lib.mkIf config.local.cli.television.enable { ... };
}
2.3. lib/ для shared helpers
Проблема: Нет lib/ директории. Catppuccin palette, workspace names, monitor config, commonFormat (starship) — всё дублируется.
Решение: Создать lib/ с:

- palette.nix — Catppuccin палитра (или использовать stylix)
- monitors.nix — конфигурация мониторов
- helpers.nix — withCooldown, commonFormat, mkAnimationProfile
  2.4. Per-host структура
  Проблема: userSettings хардкожен в flake.nix:57-65. Мониторы, xserver model, networking extraHosts, uplinkInterface — всё хардкожено. Есть ветка codex/-laptop-desktop → multi-host intent.
  Решение: Структура hosts/<hostname>/:
  hosts/
  desktop/
  hardware.nix
  networking.nix
  monitors.nix
  laptop/
  hardware.nix
  ...
- hosts/default.nix с общим. Параметризовать через nik.host опцию.
  2.5. NUR overlay не проброшен в HM
  Проблема: flake.nix:103 — stable.legacyPackages.${system}.extend unstableOverlay — NUR overlay не добавлен в HM pkgs. pkgs.nur.\* недоступен в home-manager.
  Решение: .extend (unstableOverlay ++ [inputs.nur.overlays.default]).
  2.6. nixpkgs.config.allowUnfree в 3 местах
  Проблема: hardware.nix:3, home.nix:8, flake.nix:72 (в overlay).
  Решение: Одно объявление в configuration.nix или nixos/modules/nix.nix.

3. Инструменты из awesome-nix для внедрения
   3.1. Форматирование и линтинг (высокий приоритет)
   Инструмент Что даёт Замена в конфиге
   nixfmt-rfc-style Официальный форматтер (RFC 166) Заменить nixfmt → nixfmt-rfc-style в devenv.nix
   treefmt-nix Мульти-форматтер, nix fmt работает из коробки, кэш по файлам Добавить flake-parts модуль
   nil или nixd (уже есть) LSP для Nix nixd уже в nvim after/lsp — хорошо
   nixpkgs-hammering Линтер для Nixpkgs паттернов Добавить в git-hooks
   3.2. CI/CD (высокий приоритет)
   Инструмент Что даёт
   flake-checker (Determinate Systems) Проверка flake.lock на совместимые версии nixpkgs
   hercules-ci-effects CI/CD как flake-parts модуль — checks автоматически
   GitHub Actions с nix flake check Минимальный CI: nix flake check, nix fmt --check, statix check
   Сейчас 0 CI — любой коммит может сломать сборку и это обнаружится только при nixos-rebuild.
   3.3. Кэширование (средний приоритет)
   Инструмент Что даёт
   nix-tree Интерактивный просмотр зависимостей — найти что тянет тяжёлые пакеты
   nvd Diff между поколениями — nvd diff /run/current-system "$new"
   nix-output-monitor Уже стоит в packages — но можно alias rebuild=nom
   nix-direnv Уже включён в direnv.nix — но нет .envrc в корне репо
   Решение: Добавить .envrc с use flake в корень репо — автоматическая загрузка devShell при cd.
   3.4. Документация (низкий приоритет, но важно)
   Что Зачем
   README.md Описание структуры, команды rebuild, как добавить хост
   AGENTS.md Инструкции для AI-агентов (opencode/codex) — команды lint, test, build
   manix CLI для поиска опций Nixpkgs + NixOS + HM в одном месте
   3.5. Секреты (средний приоритет)
   Инструмент Что даёт
   agenix Проще для одиночных токенов. SSH host key как ключ шифрования — не нужен отдельный PGP
   hashedPasswordFile Сейчас пароль пользователя не в sops — mutableUsers = true
   Решение: Добавить users.users.nik.hashedPasswordFile = config.sops.secrets.user_password.path; + mutableUsers = false.
   3.6. Дополнительно
   Инструмент Что даёт Приоритет
   impermanence Stateless NixOS — persist только нужное через bindMount Низкий (требует btrfs/erase-darwin)
   disko Декларативное разбиение дисков — замена hardware-configuration.nix Низкий (работает текущий)
   nixos-hardware Hardware-specific оптимизации (Intel + NVIDIA) Средний
   nix-mineral Hardening NixOS Низкий
   spicetify-nix Themed Spotify Низкий
   compose2nix Генерация NixOS-конфига из docker-compose Низкий
4. Дублирования (полный реестр)
   Что Где Решение
   Catppuccin palette (4 копии) niri.nix, rofi.nix, noctalia.nix, kitty.nix lib/palette.nix или stylix
   allowUnfree = true (3 копии) hardware.nix, home.nix, flake.nix Одно место
   dhcpcd.extraConfig (2 копии) hardware-configuration.nix:70, networking.nix:11 Убрать из hardware
   .pre-commit-config.yaml в .gitignore (2 копии) .gitignore:1 + :12 Удалить дубликат
   programs.fish.enable (2 копии) programs.nix:23, users.nix:3 Одно место
   Shell aliases (fish ↔ nushell) fish.nix:37-55, nushell.nix:483-821 Общий aliases.nix
   Novosibirsk location (2 копии) configuration.nix:26, noctalia.nix:255-257 nik.location опция
   gnutls/libGL/libx11 в nix-ld nix-ld.nix:10-13 + 47-52 Убрать дубли
5. Хардкоженные пути (заменить на config.\*)
   Путь Файл Замена
   /home/nik/.flake nixos/modules/programs.nix:8 config.dotfiles.path (пробросить в NixOS)
   /home/nik/git-repos/flux/.sops.yaml modules/flux.nix:18 config.home.homeDirectory + /git-repos/flux/.sops.yaml
   /home/nik/.local/share/icons/modrinth.png desktop.nix:67 ${config.home.homeDirectory}/.local/share/...
   /home/nik/Yandex.Disk yandex-disk.nix:5 ${config.home.homeDirectory}/Yandex.Disk
   /home/nik/.local/bin nushell.nix:294 ${config.home.homeDirectory}/.local/bin
   /home/nik/.config/... yandex-disk.nix ${config.xdg.configHome}/...
   Philips PHL32M1N5500V + metamodes xserver.nix:19-32 Per-host файл
   DP-1 2560x1440@180 + DP-2 ...@165 niri.nix:57-76 Per-host файл
   192.168.3.3 home networking.nix:13-17 Per-host файл
   eno1 sing.nix:3 Per-host файл
   55.0 / 82.9 (Novosibirsk) noctalia.nix:255-257 nik.location опция
   GPG fingerprint B77DD388... git.nix:14, gpg.nix:58-61 sops secret или nik.user.gpgKey опция
6. Приоритеты внедрения
   Быстрые победы (1-2 часа)
7. Импортировать fish.nix в cli/default.nix
8. Исправить enchancer_for_youtuve.json → enhancer_for_youtube.json
9. Убрать дубликаты в nix-ld.nix
10. nixfmt → nixfmt-rfc-style в devenv.nix
11. Убрать дубли .pre-commit-config.yaml в .gitignore
12. Заменить хардкоженные /home/nik/... на config.home.homeDirectory
13. Исправить atuin.nix sops placeholder
    Средние задачи (полдня)
14. Создать lib/palette.nix — убрать 4 копии Catppuccin
15. Добавить mkEnableOption в топ-5 самых крупных HM-модулей
16. Пробросить NUR overlay в HM
17. Добавить .envrc + use flake
18. Создать README.md + AGENTS.md
19. hashedPasswordFile + mutableUsers = false
    Крупные рефакторинги (1-2 дня)
20. Per-host структуру (hosts/desktop/, hosts/laptop/)
21. treefmt-nix вместо ручных git-hooks
22. CI: GitHub Actions / Forgejo Actions с nix flake check
23. Вынести shell aliases в общий aliases.nix (fish + nushell)
24. niri.nix (935 строк) — разбить на niri/bindings.nix, niri/layout.nix, niri/monitors.nix + lib.genList для workspace bindings
