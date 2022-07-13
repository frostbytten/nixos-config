{ config, pkgs, ... }: {
  hardware.opengl.driSupport32Bit = true;
  home-manager.users.frostbytten = {
    home.packages = with pkgs; [ steam lutris nxengine-evo ];
  };
}
