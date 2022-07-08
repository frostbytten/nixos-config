{ config, pkgs, ... }: {
  home-manager.users.frostbytten = {
    home.pkgs = with pkgs; [ steam lutris nxengine-evo ]; 
  };
}
