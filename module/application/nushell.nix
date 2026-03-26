{ vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    programs.nushell = {
      enable = true;
      extraEnv = ''
        $env.PATH = ($env.PATH | prepend [
          "/etc/profiles/per-user/${username}/bin"
          "/run/current-system/sw/bin"
          "/nix/var/nix/profiles/default/bin"
        ])
      '';
      settings = {
        show_banner = false;
      };
    };
  };
}
