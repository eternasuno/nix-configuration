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
        terminal.shell = {
          program = "${pkgs.zsh}/bin/zsh";
          args = [ "-l" "-c" "exec ${pkgs.nushell}/bin/nu" ];
        };
      };
    };
  };
}
