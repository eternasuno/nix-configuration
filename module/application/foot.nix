{ vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "monospace:size=14";
        };
        colors = {
          alpha = 0.9;
        };
        csd = {
          preferred = "none";
        };
      };
    };
  };
}
