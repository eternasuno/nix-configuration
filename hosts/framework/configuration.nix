{
  inputs,
  config,
  pkgs,
  vars,
  lib,
  ...
}:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = lib.mkForce false;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  networking = {
    hostName = vars.host;
    networkmanager.enable = true;
  };

  time.timeZone = vars.timeZone;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://cache.nixos.org?priority=10"
      "https://niri.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  console.keyMap = vars.keyboardLayout;

  security.rtkit.enable = true;

  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --asterisks --greeting Hello --cmd ${pkgs.niri}/bin/niri-session";
          user = vars.username;
        };
      };
    };
  };

  users = {
    mutableUsers = true;
    users.${vars.username} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "video"
        "wheel"
      ];
      shell = pkgs.bash;
    };
  };

  programs.dconf.enable = true;

  services.openssh.enable = true;

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.username} = {
      imports = [
        ./home.nix
      ];
      home = {
        username = vars.username;
        homeDirectory = "/home/${vars.username}";
        stateVersion = vars.version;
      };
    };
  };

  system.stateVersion = vars.version;
}
