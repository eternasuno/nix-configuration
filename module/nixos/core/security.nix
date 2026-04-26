{
  lib,
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services = {
      greetd.fprintAuth = true;
      greetd.enableGnomeKeyring = true;
      sudo.fprintAuth = true;
      login.fprintAuth = true;
      login.enableGnomeKeyring = true;
    };
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  services.dbus.packages = with pkgs; [gcr];
  environment.systemPackages = with pkgs; [libsecret];

  home-manager.users.${username} = {
    services.gnome-keyring.enable = true;

    systemd.user.services.gnome-keyring = {
      Unit.PartOf = lib.mkForce ["default.target"];
      Install.WantedBy = lib.mkForce ["default.target"];
    };
  };
}
