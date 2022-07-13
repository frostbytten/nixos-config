{ config, pkgs, ... }:
let
  backgroundColor = "#282A2E";
  backgroundAltColor = "#373B41";
  foregroundColor = "#C5C8C6";
  primaryColor = "#F0C674";
  secondaryColor = "#8ABEB7";
  alertColor = "#A54242";
  disabledColor = "#707880";
in {
  home-manager.users.frostbytten = {
    services.polybar = {
      enable = true;
      package = pkgs.polybar.override { pulseSupport = true; };
      settings = {
        "bar/top" = {
          width = "100%";
          height = "24pt";
          enable.ipc = true;
          modules.left = "bspwm i3";
          background = backgroundColor;
          foreground = foregroundColor;
          font = [ "Hasklug Nerd Font:pixelsize=10:antialias=true;3" ];
        };
        "module/bspwm" = {
          type = "internal/bspwm";
          occupied.scroll = false;
          format = "<label-state>";
          label.focused = {
            text = "%name%";
            background = backgroundAltColor;
            underline = primaryColor;
            padding = "6px";
          };
	  label.visible = {
	    text = "%name%";
	    padding = "6px";
	    };
          label.unfocused = {
            text = "%name%";
            padding = "6px";
          };
	  label.urgent = {
	    text = "%name%";
	    padding = "6px";
	    underline = alertColor;
	  };
        };
      };
      script = "polybar &";
    };
  };
}

