{ vars, inputs, ... }:
let
  inherit (vars) username version;
in
{
  imports = [
    ../../module/common/cli/bat.nix
    ../../module/common/gui/firefox.nix
    ../../module/common/cli/fzf.nix
    ../../module/nixos/gui/foot.nix
    ../../module/common/cli/git.nix
    ../../module/common/cli/lazygit.nix
    ../../module/common/cli/neovim
    ../../module/common/cli/nh.nix
    ../../module/common/cli/nushell.nix
    ../../module/common/gui/vscode.nix
    ../../module/common/cli/yazi
    ../../module/common/cli/zoxide.nix
    ../../module/nixos/core/boot.nix
    ../../module/nixos/core/fonts.nix
    ../../module/common/core/fonts.nix
    ../../module/nixos/core/networking.nix
    ../../module/common/core/nix.nix
    ../../module/nixos/core/security.nix
    ../../module/nixos/services/pipewire.nix
    ../../module/nixos/core/users.nix
    ../../module/nixos/gui/niri/greeter.nix
    ../../module/nixos/gui/gtk.nix
    ../../module/nixos/gui/fcitx5.nix
    ../../module/nixos/gui/niri
    ../../module/nixos/gui/xdg.nix
  ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit vars inputs; };
    users.${username} = {
      home = {
        username = username;
        homeDirectory = "/home/${username}";
        stateVersion = version;
      };
    };
  };

  system.stateVersion = version;
}
