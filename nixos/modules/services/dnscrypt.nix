{
  services.dnscrypt-proxy = {
    enable = true;
    # Settings reference:
    # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      cache = true;
      cache_size = 524288; # number of cache entries
      cache_min_ttl = 60; # seconds
      cache_max_ttl = 86400; # seconds

      # Add this to test if dnscrypt-proxy is actually used to resolve DNS requests
      # query_log.file = "/var/log/dnscrypt-proxy/query.log";
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      # server_names = [ ... ];

      # fallback resolvers (pure IP fallback if resolver list unavailable)
      fallback_resolvers = [
        "1.1.1.1:53"
        "9.9.9.9:53"
      ];

      # other useful options
      reject_ttl = 60; # TTL for refusals/ NXDOMAIN caching
      lb_strategy = "p2";
    };
  };
}
