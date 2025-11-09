{ vars, ... }:
{
  networking = {
    hostName = vars.host;
    networkmanager.enable = true;
  };
}
