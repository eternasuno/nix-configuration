{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    home.packages = with pkgs; [github-copilot-cli];
  };
}
