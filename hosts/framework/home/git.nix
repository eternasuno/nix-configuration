{ vars, ... }:
let
  inherit (vars) username email;
in
{
  programs.git = {
    enable = true;
    userName = "${username}";
    userEmail = "${email}";
  };
}
