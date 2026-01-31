{ vars, ... }:
let
  inherit (vars) username;
in
{
  # ====================================================
  # Home Manager Level
  # ====================================================
  home-manager.users.${username} = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
