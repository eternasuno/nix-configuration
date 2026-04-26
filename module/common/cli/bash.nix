{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.bash.enable = true;
  };
}
