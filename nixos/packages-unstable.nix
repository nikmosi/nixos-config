{ unstable, ... }:
{
  environment.systemPackages = with unstable; [
    sing-box
    sing-geoip
    sing-geosite
  ];
}
