{ vars, ... }:
let
  inherit (vars) username email;
in
{
  programs.git = {
    enable = true;
    settings.user = {
      name = "${username}";
      email = "${email}";
    };
  };
}
