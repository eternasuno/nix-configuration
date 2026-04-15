{ pkgs, vars, inputs, ... }:
let
  inherit (vars) host username;
in
{
  networking.hostName = host;

  programs.zsh.enable = true;

  users.users.${username} = {
    home = "/Users/${username}";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
}
