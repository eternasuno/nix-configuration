{ pkgs, vars, inputs, ... }:
let
  inherit (vars) host username version;
in
{
  imports = [
    ../../module/application/bat.nix
    ../../module/application/git.nix
    ../../module/application/neovim.nix
    ../../module/application/nh.nix
    ../../module/application/starship.nix
    ../../module/application/vscode.nix
    ../../module/application/zsh.nix
    ../../module/application/yazi
    ../../module/core/nix.nix
  ];

  networking.hostName = host;
  users.users.${username} = {
    home = "/Users/${username}";
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit vars inputs; };
    users.${username}.home = {
        username = username;
        homeDirectory = "/Users/${username}";
        stateVersion = version;
      };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  fonts.packages = with pkgs; [
    maple-mono.NL-TTF-AutoHint
    maple-mono.NL-NF-CN
    noto-fonts-color-emoji
  ];

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 6;
}
