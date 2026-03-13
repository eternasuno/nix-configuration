{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
  };

  home-manager.users.${username} = { config, ... }: {
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        desktop = "${config.home.homeDirectory}/Desktop";
        documents = "${config.home.homeDirectory}/Documents";
        download = "${config.home.homeDirectory}/Download";
        music = "${config.home.homeDirectory}/Music";
        pictures = "${config.home.homeDirectory}/Pictures";
        publicShare = "${config.home.homeDirectory}/Public";
        templates = "${config.home.homeDirectory}/Templates";
        videos = "${config.home.homeDirectory}/Videos";
      };
      portal = {
        xdgOpenUsePortal = true;
      };
    };
  };
}
