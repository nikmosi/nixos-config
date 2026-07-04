{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    zbar
  ];

  home.file.".local/bin/screenshot.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      case "$1" in
        area)
          grim -g "$(slurp)" - | wl-copy
          ;;
        full)
          grim - | wl-copy
          ;;
        upload)
          link=$(grim -g "$(slurp)" - | curl -fsS -F 'file=@-;type=image/png;filename=shot.png' https://i.nuuls.com/upload | tr -d '\n')
          printf '%s' "$link" | wl-copy
          notify-send -t 5000 "screenshot" "link in clipboard: $link"
          ;;
        qr)
          grim -g "$(slurp)" - | zbarimg --raw - | wl-copy
          ;;
        menu)
          choice=$(printf 'area\nfull\nupload\nqr' | rofi -dmenu -p screenshot)
          [ -n "$choice" ] && exec "$0" "$choice"
          ;;
        *)
          echo "usage: screenshot.sh {area|full|upload|qr|menu}" >&2
          exit 1
          ;;
      esac
    '';
  };
}
