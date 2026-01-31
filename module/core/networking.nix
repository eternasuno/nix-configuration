{ vars, ... }:
let
  inherit (vars) host;
in
{
  # ====================================================
  # System Level
  # ====================================================
  networking = {
    hostName = host;
    networkmanager.enable = true;
  };
}
