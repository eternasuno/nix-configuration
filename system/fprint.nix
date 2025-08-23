_: {
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  security.pam.services = {
    sudo = {
      enable = true;
      fprintAuth = true;
    };
    greetd = {
      enable = true;
      fprintAuth = true;
    };
    quickshell = {
      enable = true;
      fprintAuth = true;
    };
  };
}
