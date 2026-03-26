{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.9;
        };
        font = {
          normal = {
            family = "Maple Mono NL NF CN";
          };
          size = 14;
        };
        terminal.shell = "${pkgs.nushell}/bin/nu";
      };
    };
  };
}
