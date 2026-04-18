{
  vars,
  inputs,
  ...
}: let
  inherit (vars) username version darwinStateVersion;
in {
  imports = [
    #../../module/application/bat.nix
    ../../module/application/devenv.nix
    ../../module/application/gemini.nix
    ../../module/application/git.nix
    ../../module/application/neovim
    ../../module/application/nh.nix
    # ../../module/application/nushell.nix
    ../../module/application/starship.nix
    ../../module/application/yazi
    ../../module/application/zsh.nix
    ../../module/brew/apfel.nix
    ../../module/brew/appstore.nix
    ../../module/brew/kitty.nix
    ../../module/core/darwin.nix
    ../../module/core/fonts-packages.nix
    ../../module/core/nix.nix
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit vars inputs;};
    users.${username}.home = {
      username = username;
      homeDirectory = "/Users/${username}";
      stateVersion = version;
    };
  };

  system.primaryUser = username;
  system.stateVersion = darwinStateVersion;
}
