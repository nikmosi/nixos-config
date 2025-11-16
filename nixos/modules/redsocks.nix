{ pkgs, ... }:
let
  proxyPort = 12334; # твой локальный апстрим-прокси (должен реально слушать!)
  redPort = 12355; # порт redsocks
  upstreamType = "socks5"; # "socks5" или "http-connect"
in
{
  networking.nftables.enable = true;

  environment.systemPackages = [ pkgs.redsocks ];
}
