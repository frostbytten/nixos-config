{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [ bluezFull pavucontrol ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.blueman.enable = true;

}
