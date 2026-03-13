{ vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    programs.nushell.enable = true;
    programs.starship = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
