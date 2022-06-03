{ config, pkgs, ... }:
{
  home.username = "frostbytten";
  home.homeDirectory = "/home/frostbytten";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    kitty
    firefox
    tree
  ];

  xsession.windowManager.bspwm.enable = true;
  services.sxhkd.enable = true;
  services.sxhkd.keybindings = {
    "super + Return" = "kitty";
    "super + d" = "dmenu_run";
    "super + {_,shift + }c" = "bspc node -{c,k}";
  };

  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    pinentryFlavor = "curses";
  };


  programs.git = {
    enable = true;
    userName = "Christopher Villalobos";
    userEmail = "villalobosca@protonmail.com";
  };

  programs.password-store.enable = true;
}
