{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    curl
    fd
    git
    gnupg
    neovim
    networkmanager
    nixfmt
    pciutils
    ripgrep
    tree
    unzip
    usbutils
    zip
  ];

  nixpkgs = { config = { allowUnfree = true; }; };
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
  services.udisks2.enable = true;

  # Home Manager settings
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.frostbytten = {
    home.username = "frostbytten";
    home.homeDirectory = "/home/frostbytten";

    programs.home-manager.enable = true;

    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableBashIntegration = true;
      pinentryFlavor = "curses";
    };

    programs.git = {
      enable = true;
      userName = "Christopher Villalobos";
      userEmail = "villalobosca@protonmail.com";
    };

    programs.password-store.enable = true;
    home.stateVersion = "22.05";
  };

  # Initial states
  system.stateVersion = "22.05";
}
