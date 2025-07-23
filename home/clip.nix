{ pkgs, ... }:
{
  systemd.user.services.cliphist = {
    Unit = {
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Restart = "on-failure";
      ExecStart = "${pkgs.wl-clipboard-rs}/bin/wl-paste -t text --watch ${pkgs.cliphist}/bin/cliphist store";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
