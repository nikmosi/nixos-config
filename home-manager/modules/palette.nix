{ config, lib, ... }:
let
  paletteJson = builtins.fromJSON (
    builtins.readFile "${config.catppuccin.sources.palette}/palette.json"
  );
  flavor = config.catppuccin.flavor;
  colors = paletteJson.${flavor}.colors;
  hex = builtins.mapAttrs (_: v: v.hex) colors;
in
{
  options.dotfiles.palette = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    readOnly = true;
    default = hex;
    description = "Catppuccin palette as hex colors, keyed by color name";
  };
}
