{ vars, ... }:
let
  inherit (vars) username email;
in
{
  home-manager.users.${username} = {
    programs.git = {
      enable = true;
      settings.user = {
        name = "${username}";
        email = "${email}";
      };
    };
  };
}
