{ pkgs, ... }:

{
  services.v2raya = {
    enable = true;
    openFirewall = true;
    v2rayPackage = pkgs.xray; # v2ray-core is fine too
  };
}
