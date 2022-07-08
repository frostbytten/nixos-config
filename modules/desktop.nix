{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps";
    libinput = { enable = true; };
    autoRepeatDelay = 300;
    autoRepeatInterval = 42;
  };

  home-manager.users.frostbytten = {
    home.packages = with pkgs; [ firefox kitty ];
  };
}
