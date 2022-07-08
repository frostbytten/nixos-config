{ config, lib, pkgs, modulesPath, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  networking = {
    hostName = "kurapika";
    networkmanager.enable = true;
    interfaces = {
      enp3s0.useDHCP = lib.mkDefault true;
      wlp0s20f3.useDHCP = lib.mkDefault true;
    };
  };
  
  # Copied from the hardware-configuration.nix for kurapika
  imports =
    [
      ./kurapika-hardware.nix
    ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  hardware.opengl.enable = true;

  environment.systemPackages = [ nvidia-offload ];
  boot.loader.systemd-boot.enable = true;
  boot.kernelParams = ["nohibernate"];
  zramSwap.enable = true;
  zramSwap.memoryPercent = 150;
}
