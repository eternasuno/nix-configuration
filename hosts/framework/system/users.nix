{ pkgs, vars, ... }:
{
  console.keyMap = vars.keyboardLayout;

  users = {
    mutableUsers = true;
    users.${vars.username} = {
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
