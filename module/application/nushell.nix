{ vars, ... }:
let
  inherit (vars) username host;
in
{
  home-manager.users.${username} = {
    programs.nushell = {
      enable = true;
      settings = {
        show_banner = false;
      };
    };

    programs.starship = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
