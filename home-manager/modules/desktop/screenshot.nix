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
              choice=$(printf 'area\nfull\nupload\nqr' | anyrun --plugins libstdin.so)
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

          ENV_FILE="$HOME/.config/awesome/.env"
          API_KEY=""
          if [ -f "$ENV_FILE" ]; then
            API_KEY=$(grep -E '^WEATHER_API_KEY=' "$ENV_FILE" | cut -d= -f2- | sed 's/^"//;s/"$//' | sed 's/^'"'"'//;s/'"'"'$//')
          fi

          if [ -z "$API_KEY" ]; then
            echo "󰅎 no key"
            exit 0
          fi

          LAT=55.04
          LON=82.93
          CACHE="/tmp/waybar-weather.json"
          CACHE_TTL=600

          if [ -f "$CACHE" ] && [ "$(($(date +%s) - $(stat -c %Y "$CACHE" 2>/dev/null || echo 0)))" -lt "$CACHE_TTL" ]; then
            DATA=$(cat "$CACHE")
          else
            DATA=$(curl -fsS "https://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&appid=$API_KEY&units=metric&lang=en" 2>/dev/null) || {
              echo "󰅎 err"
              exit 0
            }
            echo "$DATA" > "$CACHE"
          fi

          TEMP=$(echo "$DATA" | jq -r '.main.temp // empty')
          ICON_CODE=$(echo "$DATA" | jq -r '.weather[0].id // 0')

          if [ -z "$TEMP" ]; then
            echo "󰅎 n/a"
            exit 0
          fi

          case "$ICON_CODE" in
            2*) ICON="󰼯" ;;
            3*) ICON="󰖗" ;;
            5*) ICON="󰖗" ;;
            6*) ICON="󰼫" ;;
            7*) ICON="󰖪" ;;
            800) ICON="󰖙" ;;
            80*) ICON="󰖕" ;;
            *) ICON="󰅎" ;;
          esac

          TOOLTIP=$(echo "$DATA" | jq -r '"\(.weather[0].description // "n/a"), \(.main.temp|round)°C, feels \(.main.feels_like|round)°C, humidity \(.main.humidity)%"')

          echo "$ICON $TEMP°C"
          echo "$TOOLTIP"
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
