{
  inputs,
  pkgs,
  vars,
  ...
}:
let
  inherit (vars) username model version;
  inherit (inputs) home-manager nixos-hardware;
in
{
  imports = [
    ../../system/boot.nix
    ../../system/fprint.nix
    ../../system/gnome.nix
    ../../system/greetd.nix
    ../../system/hardware.nix
    ../../system/lanzaboote.nix
    ../../system/locale.nix
    ../../system/network.nix
    ../../system/nix.nix
    ../../system/security.nix
    ../../system/services.nix
    ../../system/user.nix
    home-manager.nixosModules.home-manager
    nixos-hardware.nixosModules.${model}
  ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${username} = {
      imports = [
        ../../home/bat.nix
        ../../home/fcitx5.nix
        ../../home/firefox
        ../../home/foot.nix
        ../../home/git.nix
        ../../home/nh.nix
        ../../home/niri
        ../../home/nushell.nix
        ../../home/quickshell
        ../../home/starship.nix
        ../../home/vim.nix
        ../../home/xdg.nix
        ../../home/zoxide.nix
      ];
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = version;
      };
    };
  };

  system.stateVersion = version;
}
