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
    ../../system/cosmic.nix
    ../../system/locale.nix
    ../../system/network.nix
    ../../system/nix.nix
    ../../system/packages.nix
    ../../system/security.nix
    ../../system/user.nix
    home-manager.nixosModules.home-manager
    nixos-hardware.nixosModules.${model}
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${username} = {
      imports = [
        ../../home/foot.nix
        ../../home/librewolf.nix
        ../../home/firefox
        ../../home/nushell.nix
        ../../home/xdg.nix
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
