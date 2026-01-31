{ vars, ... }:
let
  inherit (vars) username;
in
{
  # ====================================================
  # Home Manager Level
  # ====================================================
  home-manager.users.${username} = {
    programs.foot = {
      enable = true;
      settings = {
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
