{ vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username}.programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    options = [
      "--cmd cd"
    ];
  };
}
