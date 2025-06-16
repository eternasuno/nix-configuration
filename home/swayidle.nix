{ pkgs, ... }: let
  lock = "${pkgs.hyprlock}/bin/hyprlock";
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    timeouts = [
      {
        timeout = 300;
        command = lock;
      }
      {
        timeout = 600;
        command = "systemctl suspend-then-hibernate";
      }
    ];
    events = [
       { event = "before-sleep"; command = lock; }
    ];
  };
}
