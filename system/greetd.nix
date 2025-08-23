{ pkgs, vars, ... }:
let inherit (vars) username;
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --asterisks --greeting Hello --cmd ${pkgs.niri}/bin/niri-session";
        user = username;
      };
    };
  };
}
