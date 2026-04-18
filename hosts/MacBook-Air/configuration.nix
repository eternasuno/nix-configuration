{
  vars,
  inputs,
  ...
}: let
  inherit (vars) username version darwinStateVersion;
in {
  imports = [
    # ../../module/common/cli/bat.nix
    ../../module/common/cli/devenv.nix
    ../../module/common/cli/gemini.nix
    ../../module/common/cli/git.nix
    ../../module/common/cli/lazygit.nix
    ../../module/common/cli/neovim
    ../../module/common/cli/nh.nix
    ../../module/common/cli/starship.nix
    ../../module/common/cli/yazi
    ../../module/common/cli/zsh.nix
    ../../module/common/core/fonts.nix
    ../../module/common/core/nix.nix
    ../../module/common/gui/kitty.nix
    ../../module/darwin/cli/apfel.nix
    ../../module/darwin/core/system.nix
    ../../module/darwin/gui/appstore.nix
    ../../module/darwin/gui/kitty.nix
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
