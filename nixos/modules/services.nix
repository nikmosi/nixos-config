{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  services.greenclip.enable = true;
  services.libinput = {
    enable = true;
    touchpad.accelProfile = "flat";
    mouse.accelProfile = "flat";
  };
}
