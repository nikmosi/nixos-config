{ lib, inputs, ... }:
let
  hostModules = {
    laptop = ./hosts/laptop.nix;
    desktop = ./hosts/desktop.nix;
  };

  rawHost = builtins.getEnv "NIXOS_HOST_TYPE";
  lowerHost = lib.strings.toLower rawHost;

  selectedHostModule =
    if rawHost == "" then
      lib.warn "NIXOS_HOST_TYPE не задан, используется модуль desktop." hostModules.desktop
    else if builtins.hasAttr lowerHost hostModules then
      hostModules.${lowerHost}
    else
      lib.warn "Неизвестное значение NIXOS_HOST_TYPE, используется модуль desktop." hostModules.desktop;
in
{
  imports = [
    ./modules/default.nix
    ./nixos-packages.nix
    ./hardware-configuration.nix
    selectedHostModule
  ];

  # Этот файл сохранён для совместимости с не-flake сценарием. Для новых
  # машин предпочтительнее использовать `nixosConfigurations.<host>` из flake.
}
