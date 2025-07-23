_: {
  services = {
    gnome.gnome-keyring.enable = true; # Collection of components in GNOME that store secrets, passwords, keys, certificates and make them available to applications.
  };

  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
