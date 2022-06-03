{ config, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  users.users.frostbytten = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  console.useXkbConfig = true;
  system.stateVersion = "22.05";
}
