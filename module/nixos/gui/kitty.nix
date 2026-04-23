{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.kitty = {
      settings = {
        shell = "nu";
      };
    };
    home.sessionVariables = {
      TERMINAL = "kitty";
    };
  };
}
