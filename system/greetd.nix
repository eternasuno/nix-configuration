{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        command = "${pkgs.niri}/bin/niri-session";
        user = username;
      };
    };
  };

  systemd = {
    # To prevent getting stuck at shutdown
    extraConfig = "DefaultTimeoutStopSec=10s";
    # services.greetd.serviceConfig = {
    #   Type = "idle";
    #   StandardInput = "tty";
    #   StandardOutput = "tty";
    #   StandardError = "journal";
    #   TTYReset = true;
    #   TTYVHangup = true;
    #   TTYVTDisallocate = true;
    # };
  };
}
