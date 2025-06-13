_: {
  programs.swayidle = {
    enable = true;
    systemdTarget = "sway-session.target";
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 600;
        command = "systemctl suspend-then-hibernate";
      }
    ];
    beforeSleep = "${pkgs.swaylock}/bin/swaylock -f";
  };
}
