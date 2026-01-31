{ vars, inputs, ... }:
let
  inherit (vars) username version;
in
{
  imports = [
    # Core modules
    ../../module/core/boot.nix
    ../../module/core/fonts.nix
    ../../module/core/networking.nix
    ../../module/core/nix.nix
    ../../module/core/security.nix
    ../../module/core/services.nix
    ../../module/core/users.nix

    # Desktop modules
    ../../module/desktop/gtk.nix
    ../../module/desktop/input-method.nix
    ../../module/desktop/niri.nix
    ../../module/desktop/xdg.nix

    # Application modules
    ../../module/application/firefox.nix
    ../../module/application/foot.nix
    ../../module/application/git.nix
    ../../module/application/neovim.nix
    ../../module/application/vscode.nix
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
