{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
    ripgrep
    usbutils
    unzip
    zip
    dmenu
    kitty
    pcmanfm
    networkmanager
    nitrogen
    pciutils
  ];
}
