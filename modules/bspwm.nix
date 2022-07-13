{ config, pkgs, ... }: {
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.displayManager.defaultSession = "none+bspwm";

  home-manager.users.frostbytten = {
    home.packages = with pkgs; [ dmenu nitrogen ];
    xsession.enable = true;

    xsession.windowManager.bspwm = {
      enable = true;
      alwaysResetDesktops = true;
      monitors = {
        eDP-1 = [ "α" "β" "γ" "δ" "ε" ];
        HDMI-1 = [ "ζ" "η" "θ" "ι" "κ" ];
      };
      startupPrograms = [ "nitrogen --restore" ];
    };

    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "kitty";
        "super + d" = "dmenu_run";
        "super + {_,shift + }c" = "bspc node -{c,k}";
        "super + {Up,Down,Left,Right}" = "bspc node -f {north,south,west,east}";
        "super + {1-9,0}" = "bspc desktop --focus ^{1-9,10}";
        "super + ctrl + {Left, Right}" =
          "bspc desktop --focus {prev,next}.occupied";
        "super + shift + {1-9,0}" = "bspc node --to-desktop ^{1-9,10} --focus";
        "super + ctrl + shift + {Left, Right}" =
          "bspc node --to-desktop {prev,next} --focus";
      };
    };

    services.dunst.enable = true;
  };

  imports = [ ./polybar.nix ];

}
