{ config, pkgs, ... }: {
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.displayManager.defaultSession = "none+bspwm";

  home-manager.users.frostbytten = {
    home.packages = with pkgs; [ dmenu ];
    xsession.enable = true;

    xsession.windowManager.bspwm = {
      enable = true;
      alwaysResetDesktops = true;
      monitors = {
        eDP-1 = [ "א" "ב" "ג" "ד" "ה" ];
        HDMI-1 = [ "α" "β" "γ" "δ" "ε" ];
      };
    };

    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "kitty";
        "super + d" = "dmenu_run";
        "super + {_,shift + }c" = "bspc node -{c,k}";
        "super + {Up,Down,Left,Right}" = "bspc node -f {north,south,west,east}";
        "super + {1-9,0}" = "bspc desktop --focus ^{1-9,0}";
        "super + ctrl + {Left, Right}" =
          "bspc desktop --focus {prev,next}.occupied";
        "super + shift + {1-9,0}" = "bspc node --to-desktop ^{1-9,0} --focus";
        "super + ctrl + shift + {Left, Right}" =
          "bspc node --to-desktop {prev,next} --focus";
      };
    };

    services.dunst.enable = true;
  };
}
