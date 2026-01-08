# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal NixOS configuration for a Framework 13 laptop running Hyprland (Wayland compositor). The configuration uses flakes and home-manager for declarative system and user environment management.

## Architecture

### Configuration Structure

The repository follows a modular structure with three primary entry points:

1. **flake.nix** - Defines the system configuration named "framework" with:
   - nixpkgs (unstable channel)
   - nixos-hardware modules for AMD CPU and SSD optimizations
   - home-manager for user-level configuration

2. **configuration.nix** - System-level NixOS configuration including:
   - Bootloader (systemd-boot)
   - Hardware (AMD GPU, v4l2loopback for OBS virtual camera)
   - Hyprland window manager
   - greetd/tuigreet for login
   - PipeWire for audio
   - Ollama service with deepseek-r1:1.5b and llama3.2 models
   - System packages

3. **home.nix** - User-level home-manager configuration that imports modular program configurations from `programs/`

### Program Modules

All user-level program configurations live in `programs/` directory as separate `.nix` files:

- **agents.nix** - AI coding tools (Claude Code via npx, aider-chat, gh-dash)
- **aliases.nix** - Shell aliases
- **browsers.nix** - Web browsers
- **common.nix** - Common CLI tools and utilities (ripgrep, jq, htop, fonts)
- **ghostty.nix** - Terminal emulator with Catppuccin Mocha theme, auto-launches Zellij
- **git.nix** - Git configuration with user details
- **hyprland.nix** - Hyprland window manager configuration with keybindings, waybar, hyprpaper
- **launcher.nix** - Application launcher
- **obs.nix** - OBS Studio configuration
- **taskwarrior.nix** - Task management
- **waybar.nix** - Status bar configuration for Hyprland
- **zellij.nix** - Terminal multiplexer

### Key Design Patterns

- **Modular approach**: Each program gets its own `.nix` file imported by home.nix
- **Home-manager integration**: User configuration is separate from system configuration
- **Declarative packages**: Each module declares its required packages inline using `home.packages` or `programs.<name>.enable`
- **Session variables**: Wayland/Hyprland environment variables set in home.nix

## Common Commands

### Building and Applying Configuration

```bash
# Rebuild and switch to new system configuration
sudo nixos-rebuild switch --flake .#framework

# Test new configuration without switching boot default
sudo nixos-rebuild test --flake .#framework

# Build configuration without activating
sudo nixos-rebuild build --flake .#framework

# Update flake inputs (nixpkgs, home-manager, etc.)
nix flake update
```

### Flake Operations

```bash
# Show flake metadata and outputs
nix flake show

# Check flake for errors
nix flake check

# Update specific input
nix flake lock --update-input nixpkgs
```

### Development Workflow

When adding new programs:

1. Create a new `.nix` file in `programs/` directory
2. Add the import to `home.nix` imports list
3. Rebuild with `sudo nixos-rebuild switch --flake .#framework`

### System Information

```bash
# View current system generation
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Garbage collect old generations
sudo nix-collect-garbage --delete-older-than 7d

# Optimize nix store
nix-store --optimize
```

## Hardware-Specific Notes

- **Monitor**: HDMI-A-1 configured at 2256x1504 with 1.60 scaling (see programs/hyprland.nix:7)
- **Keyboard layout**: GB (British)
- **Special hardware**: ZSA Moonlander keyboard (keymapp configured)
- **Bluetooth**: Enabled with experimental features and FastConnectable
- **GPU**: AMD with amdgpu driver
- **Kernel**: Latest kernel with specific parameters for Bluetooth autosuspend and PCIe ASPM

## Hyprland Configuration

- **Mod key**: SUPER (Windows key)
- **Terminal**: Ghostty (SUPER+Return)
- **Launcher**: hyprlauncher (SUPER+Space)
- **Navigation**: Vim-style (hjkl) for window focus
- **Workspaces**: 4 workspaces configured (SUPER+1-4)
- **Auto-start**: waybar, blueman-applet, polkit-gnome-authentication-agent

## AI Development Tools

This configuration includes several AI coding assistants:

- **Claude Code**: Available as `claude` command (or `cc` alias), uses npx to run latest version
- **Aider**: Available as `aider-chat` for AI pair programming
- **Quick query**: Use `ask` alias for one-off Claude queries

The CLAUDE_EDITOR environment variable is set to "nvim".
