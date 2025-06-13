{ pkgs, vars, ... }:
let inherit (vars) username;
in {
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
}
