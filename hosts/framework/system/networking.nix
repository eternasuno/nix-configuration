{ vars, ... }:
let
  inherit (vars) host;
in
{
  networking = {
    hostName = host;
    networkmanager.enable = true;
  };
}
