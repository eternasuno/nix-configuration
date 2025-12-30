{ vars, inputs, ... }:
let
  inherit (vars) username version;
in
{
  imports = [
    ../../system/boot.nix
    ../../system/networking.nix
    ../../system/nix.nix
    ../../system/fonts.nix
    ../../system/security.nix
    ../../system/services.nix
    ../../system/users.nix
    ../../system/greeter.nix
    ../../system/xdg.nix
  ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${username} = {
      imports = [
        ../../home/firefox.nix
        ../../home/foot.nix
        ../../home/git.nix
        ../../home/neovim.nix
        ../../home/gtk.nix
        ../../home/input-method.nix
        ../../home/xdg.nix
        ../../home/vscode.nix
        ../../home/desktop.nix
      ];
      home = {
        username = username;
        homeDirectory = "/home/${username}";
        stateVersion = version;
      };
    };
  };

  system.stateVersion = version;
}
