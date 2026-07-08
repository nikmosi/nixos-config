{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      grim
      slurp
      wl-clipboard
      zbar
      jq
      curl
      pulseaudio
    ];

    file = {
      ".local/bin/screenshot.sh" = {
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
              choice=$(printf 'area\nfull\nupload\nqr' | rofi -dmenu -display-input 'Screenshot')
              [ -n "$choice" ] && exec "$0" "$choice"
              ;;
            *)
              echo "usage: screenshot.sh {area|full|upload|qr|menu}" >&2
              exit 1
              ;;
          esac
        '';
      };

      ".local/bin/weather.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          set -euo pipefail

          CITY_FILE="$HOME/.config/weather/city"
          if [ ! -f "$CITY_FILE" ]; then
            printf '{"text":"󰅎 no city","tooltip":"weather city not set"}\n'
            exit 0
          fi
          CITY=$(tr -d '[:space:]' < "$CITY_FILE")

          CACHE="/tmp/waybar-weather.json"
          CACHE_TTL=600

          if [ -f "$CACHE" ] && [ "$(($(date +%s) - $(stat -c %Y "$CACHE" 2>/dev/null || echo 0)))" -lt "$CACHE_TTL" ]; then
            DATA=$(cat "$CACHE")
          else
            DATA=$(curl -fsS "https://wttr.in/''${CITY}?format=j1" 2>/dev/null) || {
              printf '{"text":"󰅎 err","tooltip":"wttr.in request failed"}\n'
              exit 0
            }
            echo "$DATA" > "$CACHE"
          fi

          CUR=$(echo "$DATA" | jq -r '.current_condition[0]')
          TEMP=$(echo "$CUR" | jq -r '.temp_C')
          FEELS=$(echo "$CUR" | jq -r '.FeelsLikeC')
          HUMID=$(echo "$CUR" | jq -r '.humidity')
          DESC=$(echo "$CUR" | jq -r '.weatherDesc[0].value')
          WCODE=$(echo "$CUR" | jq -r '.weatherCode')
          WIND_DIR=$(echo "$CUR" | jq -r '.winddir16Point')
          WIND_KPH=$(echo "$CUR" | jq -r '.windspeedKmph')

          case "$WCODE" in
            113)                          ICON="󰖙" ;;
            116)                          ICON="󰖕" ;;
            119|122)                      ICON="󰖕" ;;
            143|248|249|260|263)          ICON="󰖪" ;;
            200|386|389|392|395)          ICON="󰼯" ;;
            227|230|320|323|326|329|332|335|338|368|371|374|377) ICON="󰼫" ;;
            176|179|182|185|266|281|284|293|296|299|302|305|308|311|314|317|350|353|356|359|362|365) ICON="󰖗" ;;
            *)                            ICON="󰅎" ;;
          esac

          TOOLTIP="<b>''${DESC} ''${TEMP}°C</b>"
          TOOLTIP="''${TOOLTIP}\\nFeels like: ''${FEELS}°C"
          TOOLTIP="''${TOOLTIP}\\nHumidity: ''${HUMID}%"
          TOOLTIP="''${TOOLTIP}\\nWind: ''${WIND_KPH} km/h (''${WIND_DIR})"

          printf '{"text":"%s %s°C","tooltip":"%s"}\n' "$ICON" "$TEMP" "$TOOLTIP"
        '';
      };

      ".local/bin/mem.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          awk '
            /MemTotal/     {t=$2}
            /MemAvailable/ {a=$2}
            END {
              used=t-a
              gb_used = used/1000000
              gb_total = t/1000000
              printf "󰍛 %.1f/%.1f GB\n", gb_used, gb_total
            }' /proc/meminfo
        '';
      };

      # Cycle default audio source (microphone) to the next one.
      ".local/bin/cycle-source.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          set -euo pipefail

          sources=$(pactl list short sources | grep -v "\.monitor$" | awk '{print $2}')
          if [ -z "$sources" ]; then
            exit 0
          fi

          current=$(pactl get-default-source 2>/dev/null || echo "")
          mapfile -t arr <<< "$sources"
          count=''${#arr[@]}

          idx=0
          for i in "''${!arr[@]}"; do
            if [ "''${arr[$i]}" = "$current" ]; then
              idx=$(( (i + 1) % count ))
              break
            fi
          done

          pactl set-default-source "''${arr[$idx]}"
          notify-send -t 2000 "Audio Source" "Switched to ''${arr[$idx]}"
        '';
      };

      # Mute default audio source (microphone).
      ".local/bin/mute-source.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          pactl set-source-mute @DEFAULT_SOURCE@ toggle
          muted=$(pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | grep -o "yes\|no")
          if [ "$muted" = "yes" ]; then
            notify-send -t 1500 "Microphone" "Muted"
          else
            notify-send -t 1500 "Microphone" "Unmuted"
          fi
        '';
      };
    };
  };
}
