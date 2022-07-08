{ config, pkgs, ... }: {
  services.xserver.displayManager.defaultSession = "none+bspwm";

  home-manager.users.frostbytten = {
    xsession.enable = true;
    xsession.windowManager.bspwm = {
      enable = true;
      alwaysResetDesktops = true;
    };

    services.sxhkd = {
      enable = true;
    "super + Return" = "kitty";
    "super + d" = "dmenu_run";
    "super + {_,shift + }c" = "bspc node -{c,k}";
    "super + {Up,Down,Left,Right}" = "bspc node -f {north,south,west,east}"
    };
  };
}
