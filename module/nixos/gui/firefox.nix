{  vars, ... }:
let
  inherit (vars) username;
in
{
  environment.sessionVariables = {
    BROWSER = "${pkgs.firefox}/bin/firefox";
  };
}
