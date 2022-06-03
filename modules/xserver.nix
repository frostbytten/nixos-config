{config, pkgs, ...}:
{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "none+bspwm";
    windowManager.bspwm.enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps";
    libinput = {
      enable = true;
    };
    autoRepeatDelay = 300;
    autoRepeatInterval = 42;
 };
}
