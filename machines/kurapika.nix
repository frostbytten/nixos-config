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
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b987294a-07ef-4af4-ba3b-03fe5593d2e6";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=root" ];
    };

  boot.initrd.luks.devices."vault101".device = "/dev/disk/by-uuid/5a4eea18-ec34-474d-b260-a389d57f7d77";

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/b987294a-07ef-4af4-ba3b-03fe5593d2e6";
      fsType = "btrfs";
      options = [ "noatime" "subvol=swap" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/ED66-CF5A";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/b987294a-07ef-4af4-ba3b-03fe5593d2e6";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/b987294a-07ef-4af4-ba3b-03fe5593d2e6";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "subvol=nix" ];
    };

  swapDevices = [ { device="/swap/swapfile"; } ];
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
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
}
