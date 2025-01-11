{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  services.greenclip.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

}
