{ config, pkgs, ... }: {
  home-manager.users.frostbytten = {
    home.packages = with pkgs; [ jetbrains.idea-ultimate vscode-with-extensions delta ];
  };
}

