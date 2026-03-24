{ vars, inputs, ... }:
let
  inherit (vars) host username version timeZone;
in
{
  imports = [
    ../../module/application/cli
    ../../module/application/git.nix
    ../../module/application/neovim.nix
    ../../module/application/nushell.nix
    ../../module/application/starship.nix
    ../../module/application/vscode.nix
  ];

  networking.hostName = host;
  time.timeZone = timeZone;

  users.users.${username} = {
    home = "/Users/${username}";
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit vars inputs; };
    users.${username} = {
      home = {
        username = username;
        homeDirectory = "/Users/${username}";
        stateVersion = version;
      };
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.zsh.enable = true;

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 6;
}
