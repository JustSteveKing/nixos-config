# NixOS Configuration

Personal NixOS configuration for Framework Desktop with Hyprland window manager.

## Features

- **Window Manager**: Hyprland (Wayland compositor) with vim-style navigation
- **Terminal**: Ghostty with Catppuccin Mocha theme + Zellij multiplexer
- **Login Manager**: greetd with tuigreet for clean TTY-based login
- **Audio**: PipeWire with full ALSA and PulseAudio compatibility
- **AI Tools**: Claude Code, Aider, and local Ollama models (deepseek-r1:1.5b, llama3.2)
- **Hardware Support**: AMD GPU, ZSA Moonlander keyboard, Bluetooth with experimental features

## System Specifications

- **Device**: Framework Desktop
- **CPU**: AMD (with nixos-hardware optimizations)
- **GPU**: AMD (amdgpu driver)
- **Display**: 2256x1504 @ 1.60 scaling
- **Keyboard Layout**: GB (British)
- **Kernel**: Latest Linux kernel

## Quick Start

### Initial Installation

1. Clone this repository:
```bash
git clone git@github.com:JustSteveKing/nixos-config.git ~/nixos-config
cd ~/nixos-config
```

2. Review and update hardware-specific settings:
   - `hardware-configuration.nix` - Generate with `nixos-generate-config`
   - `programs/hyprland.nix` - Adjust monitor configuration
   - `configuration.nix` - Update timezone, locale, username

3. Apply the configuration:
```bash
sudo nixos-rebuild switch --flake .#framework
```

### Updating the System

```bash
# Update flake inputs (nixpkgs, home-manager, etc.)
nix flake update

# Apply updates
sudo nixos-rebuild switch --flake .#framework
```

## Project Structure

```
.
├── flake.nix                  # Flake configuration with inputs and outputs
├── configuration.nix          # System-level NixOS configuration
├── hardware-configuration.nix # Hardware-specific settings
├── home.nix                   # Home-manager user configuration
└── programs/                  # Modular program configurations
    ├── agents.nix            # AI coding tools
    ├── aliases.nix           # Shell aliases
    ├── browsers.nix          # Web browsers
    ├── common.nix            # Common utilities
    ├── ghostty.nix           # Terminal emulator
    ├── git.nix               # Git configuration
    ├── hyprland.nix          # Window manager config
    ├── launcher.nix          # Application launcher
    ├── obs.nix               # OBS Studio
    ├── taskwarrior.nix       # Task management
    ├── waybar.nix            # Status bar
    └── zellij.nix            # Terminal multiplexer
```

## Hyprland Keybindings

| Key Combination | Action |
|----------------|--------|
| `SUPER + Return` | Open terminal (Ghostty) |
| `SUPER + Q` | Close focused window |
| `SUPER + Space` | Launch application menu |
| `SUPER + F` | Open Firefox |
| `SUPER + E` | Open file manager (Nautilus) |
| `SUPER + O` | Open OBS Studio |
| `SUPER + V` | Toggle floating mode |
| `SUPER + M` | Exit Hyprland |
| `SUPER + H/J/K/L` | Navigate windows (vim-style) |
| `SUPER + 1/2/3/4` | Switch to workspace 1-4 |
| `SUPER + SHIFT + 1/2/3/4` | Move window to workspace 1-4 |

## Adding New Programs

1. Create a new file in `programs/` directory:
```nix
# programs/example.nix
{ pkgs, ... }:

{
  programs.example = {
    enable = true;
    # configuration here
  };

  # Or for packages without home-manager module:
  home.packages = with pkgs; [
    example-package
  ];
}
```

2. Import it in `home.nix`:
```nix
imports = [
  # ... existing imports
  ./programs/example.nix
];
```

3. Rebuild:
```bash
sudo nixos-rebuild switch --flake .#framework
```

## Maintenance

### Cleanup Old Generations

```bash
# List system generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Delete generations older than 7 days
sudo nix-collect-garbage --delete-older-than 7d

# Optimize nix store
nix-store --optimize
```

### Rollback

If something breaks after an update:

```bash
# Boot into previous generation (select in bootloader)
# Or rollback and switch:
sudo nixos-rebuild switch --rollback
```

## AI Development Tools

This configuration includes several AI assistants:

- **Claude Code**: `claude` or `cc` - Interactive AI coding assistant
- **Quick queries**: `ask` - One-off Claude queries (e.g., `ask "explain this error"`)
- **Aider**: `aider-chat` - AI pair programming in terminal
- **Ollama**: Local LLM service running deepseek-r1:1.5b and llama3.2

## Customization

### Personal Information

Update the following files with your details:

- `programs/git.nix` - Git username and email
- `configuration.nix` - User account, timezone, locale
- `services.hyprpaper` wallpaper path in `programs/hyprland.nix`

### Theme and Appearance

- Terminal theme: `programs/ghostty.nix` (currently Catppuccin Mocha)
- Window manager colors: `programs/hyprland.nix` (border colors)
- Status bar: `programs/waybar.nix` and `programs/waybar-style.css`

## Notes

- This configuration uses flakes (requires `nix.settings.experimental-features = [ "nix-command" "flakes" ]`)
- Hardware configuration is specific to Framework 13 with AMD CPU
- Bluetooth has experimental features enabled for better connectivity
- OBS virtual camera configured via v4l2loopback

## License

This is a personal configuration. Feel free to use as reference or template for your own setup.
