{ pkgs, ... }:
{
  systemd.user.services.swaybg = {
    Unit = {
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Restart = "on-failure";
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${../assets/wallpaper.jpg} -m fill";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
