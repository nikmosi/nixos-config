{ ... }:
{
  services.caddy = {
    enable = true;

    globalConfig = ''
      servers {
          client_ip_headers X-Forwarded-For X-Real-IP
          trusted_proxies static private_ranges
          trusted_proxies_strict
      }
    '';

    virtualHosts = {
      "jelly.4041.su".extraConfig = ''
        reverse_proxy http://localhost:8096
      '';

      "search.4041.su".extraConfig = ''
        # Анонимизация логов теперь живет здесь и защищает только SearXNG
        log {
            output stderr
            format filter {
                request>remote_ip ip_mask 8 32
                request>client_ip ip_mask 8 32
                request>remote_port delete
                request>headers delete
                request>uri query {
                    delete url
                    delete h
                    delete q
                }
            }
        }

        encode zstd gzip

        @api {
            path /config
            path /healthz
            path /stats/errors
            path /stats/checker
        }

        @search {
            path /search
        }

        @imageproxy {
            path /image_proxy
        }

        @static {
            path /static/*
        }

        header {
            Content-Security-Policy "upgrade-insecure-requests; default-src 'none'; script-src 'self'; style-src 'self' 'unsafe-inline'; form-action 'self' https:; font-src 'self'; frame-ancestors 'self'; base-uri 'self'; connect-src 'self'; img-src * data:; frame-src https:;"
            Permissions-Policy "accelerometer=(),camera=(),geolocation=(),gyroscope=(),magnetometer=(),microphone=(),payment=(),usb=()"
            Referrer-Policy "no-referrer"
            Strict-Transport-Security "max-age=31536000"
            X-Content-Type-Options "nosniff"
            X-Robots-Tag "noindex, noarchive, nofollow"
            -Server
        }

        header @api {
            Access-Control-Allow-Methods "GET, OPTIONS"
            Access-Control-Allow-Origin "*"
        }

        route {
            header Cache-Control "max-age=0, no-store"
            header @search Cache-Control "max-age=5, private"
            header @imageproxy Cache-Control "max-age=604800, public"
            header @static Cache-Control "max-age=31536000, public, immutable"
        }

        reverse_proxy localhost:8080 {
            header_up Connection "close"
        }
      '';
    };
  };
}
