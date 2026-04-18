{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.gemini-cli = {
      enable = true;
    };
  };
}
