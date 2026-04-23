{
  vars,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.kitty = {
      settings = {
        shell = "${pkgs.nushell}/bin/nu";
      };
    };

    home.sessionVariables = {
      TERMINAL = "kitty";
    };
  };
}
