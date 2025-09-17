{
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  services.pulseaudio.enable = true;
}
