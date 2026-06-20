{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    sing-box
    sing-geoip
    sing-geosite
  ];
}
