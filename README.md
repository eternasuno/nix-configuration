# NixOS Configuration

NixOS configuration for a [Framework 13 (AMD Ryzen 7040)](https://frame.work/laptop-13-amd) laptop.

## Structure

```
.
├── flake.nix                     # Flake entry point, inputs and outputs
├── hosts/
│   └── framework/
│       ├── default.nix           # Host-level variables and nixosSystem definition
│       ├── configuration.nix     # Module imports and home-manager setup
│       └── hardware-configuration.nix  # Generated hardware config
└── module/
    ├── application/
    │   ├── firefox.nix           # Firefox with textfox theme
    │   ├── foot.nix              # Foot terminal emulator
    │   ├── git.nix               # Git configuration
    │   ├── neovim.nix            # Neovim as default editor
    │   └── vscode.nix            # VS Code with user settings
    ├── core/
    │   ├── boot.nix              # Secure boot (lanzaboote), plymouth, zen kernel
    │   ├── fonts.nix             # Maple Mono + Noto Color Emoji
    │   ├── networking.nix        # NetworkManager
    │   ├── nix.nix               # Nix settings, binary caches, nh helper
    │   ├── security.nix          # rtkit, PAM fingerprint auth
    │   ├── services.nix          # PipeWire, UPower, fwupd, Bluetooth, SSH
    │   └── users.nix             # User account definition
    └── desktop/
        ├── greeter.nix           # DankMaterialShell greeter with niri compositor
        ├── gtk.nix               # GTK theme (Adwaita)
        ├── input-method.nix      # fcitx5 with Rime for CJK input
        ├── niri.nix              # Niri Wayland compositor + keybinds
        └── xdg.nix              # XDG portals and user directories
```

## Key Technologies

| Component | Choice |
|-----------|--------|
| NixOS channel | `nixos-unstable` |
| Secure Boot | [lanzaboote](https://github.com/nix-community/lanzaboote) |
| Kernel | `linuxPackages_zen` |
| Window Manager | [niri](https://github.com/YaLTeR/niri) (Wayland, scrollable tiling) |
| Shell/Greeter | [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell) |
| Terminal | [foot](https://codeberg.org/dnkl/foot) |
| Browser | Firefox with [textfox](https://github.com/adriankarlen/textfox) |
| Editor | Neovim (default) + VS Code |
| Input Method | fcitx5 + Rime |
| Font | [Maple Mono](https://github.com/subframe7536/maple-font) |
| Home Manager | Managed via NixOS module |

## Usage

```bash
# Apply system configuration
nh os switch

# Update flake inputs
nix flake update

# Garbage collect old generations (handled automatically by nh)
nh clean all
```

The flake path defaults to `~/.nixos`. To use a different location, update the `flake` setting in `module/core/nix.nix`.
