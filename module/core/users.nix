{ pkgs, vars, ... }:
let
  inherit (vars) username keyboardLayout;
in
{
  # ====================================================
  # System Level
  # ====================================================
  console.keyMap = keyboardLayout;

  users = {
    mutableUsers = true;
    users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "video"
        "wheel"
      ];
      shell = pkgs.bash;
    };
  };
}
