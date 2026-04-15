{ pkgs, vars, inputs, ... }:
let
  inherit (vars) host username version darwinStateVersion;
in
{
  imports = [
    ../../module/application/alacritty.nix
    ../../module/application/bat.nix
    ../../module/application/devenv.nix
    ../../module/application/git.nix
    ../../module/application/neovim.nix
    ../../module/application/nh.nix
    ../../module/application/nushell.nix
    ../../module/application/starship.nix
    ../../module/application/vscode.nix
    ../../module/application/yazi
    ../../module/application/zsh.nix
    ../../module/core/darwin.nix
    ../../module/core/fonts-packages.nix
    ../../module/core/nix.nix
  ];

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

  system.stateVersion = darwinStateVersion;
}
