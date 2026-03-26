{ vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    programs.eza = {
      enable = true;
      icons = "auto";
      enableNushellIntegration = true;
      git = true;

      extraOptions = [
        "--group-directories-first"
        "--no-quotes"
        "--header"
        "--git-ignore"
        "--icons=always"
        "--classify"
        "--hyperlink"
      ];
    };

    home.shellAliases = {
      ls = "eza";
      lt = "eza --tree --level=2";
      ll = "eza -lh --no-user --long";
      la = "eza -lah";
      tree = "eza --tree";
    };
  };
}
