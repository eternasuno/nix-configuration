{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  users = {
    mutableUsers = true;
    users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "adbusers"
        "libvirtd"
        "networkmanager"
        "video"
        "wheel"
      ];
      shell = pkgs.bash;
    };
  };
}
