# NixOS Configuration

This repository contains the complete NixOS configuration for my Framework Desktop, built with Nix Flakes and managed by Home Manager. It is designed to be a reproducible, well-organized, and easily maintainable setup for a Hyprland-based desktop environment.

## Features

- **Declarative & Reproducible**: The entire system, from the kernel to application dotfiles, is defined as code.
- **Window Manager**: Hyprland (Wayland compositor) with vim-style navigation.
- **Terminal**: Ghostty with the Catppuccin Mocha theme and Zellij for terminal multiplexing.
- **Login Manager**: `greetd` with `tuigreet` for a clean, TTY-based login experience.
- **Creative Tools**: Kdenlive for video editing.
- **Modular Structure**: System and home configurations are cleanly separated and broken down into logical, easy-to-manage modules.

---

## Structure Overview

The configuration is split into three main parts, promoting a clean separation of concerns:

```
.
├── flake.nix                  # Main entrypoint: defines flake inputs and outputs.
├── configuration.nix          # Top-level system configuration.
├── home.nix                   # Top-level user configuration for Home Manager.
│
├── system/                    # System-level modules (hardware, services, etc.).
│   ├── boot.nix
│   ├── hardware.nix
│   └── ...
│
└── programs/                  # User-level program configurations.
    ├── desktop/               # Desktop environment (Hyprland, Waybar, etc.).
    ├── shell/                 # Shell tools (aliases, zellij, etc.).
    ├── editors/               # Code editors.
    └── dev/                   # Development tools and languages.
```

-   **`flake.nix`**: The heart of the configuration, defining all dependencies (`nixpkgs`, `home-manager`, etc.) and tying the system and home configurations together.
-   **`system/`**: Contains all system-wide modules. Instead of a single monolithic file, `configuration.nix` simply imports the modules from this directory.
-   **`programs/`**: Contains all user-specific program configurations, managed by Home Manager. It's further divided into categories like `desktop`, `shell`, and `editors` for clarity.

---

## Makefile Workflow

A `Makefile` is provided to simplify the most common management tasks. Use `make` or `make help` to see all available commands.

### System Management

-   **`make switch`**: The most common command. Builds the new configuration and immediately activates it.
-   **`make test`**: Builds the configuration but does not activate it. This is useful for checking for errors before committing to a change.
-   **`make boot`**: Builds the configuration and makes it the default option in the bootloader, but does not activate it until the next reboot.

### Code Quality

-   **`make fmt`**: Automatically formats all `.nix` files in the repository using `nixpkgs-fmt`.
-   **`make lint`**: Runs a series of checks to find potential errors, style issues, and unused code in your configuration.

### Maintenance & History

-   **`make update`**: Updates all flake inputs (e.g., `nixpkgs`) to their latest versions and updates the `flake.lock` file.
-   **`make gc`**: Cleans up your system by removing old, unused Nix generations and optimizing the Nix store to save space.
-   **`make history`**: Lists all previous system generations.
-   **`make diff`**: Shows the changes between the current and previous system generations.

---

## Customization

### Adding a New Program

1.  **Choose a Category**: Decide which subdirectory in `programs/` the new application belongs to (e.g., `desktop`, `shell`, `dev`).
2.  **Create the File**: Create a new `.nix` file for your program in that directory (e.g., `programs/shell/my-new-tool.nix`).
3.  **Add to `default.nix`**: Open the `default.nix` file within that same directory and add your new file to the `imports` list.
    ```nix
    # In programs/shell/default.nix
    {
      imports = [
        ./aliases.nix
        ./ghostty.nix
        ./zellij.nix
        ./my-new-tool.nix  # Add your new file here
      ];
    }
    ```
4.  **Rebuild**: Apply your configuration using `make switch`.

### Personal Information

-   **Git**: Update `programs/dev/git.nix` with your username and email.
-   **System**: Update `system/users.nix` and `system/environment.nix` with your user details, timezone, and locale.
-   **Theme**: Theming is managed in `programs/desktop/theme.nix`. Terminal colors are in `programs/shell/ghostty.nix`.

---

## Keybindings (Hyprland)

| Key Combination          | Action                         |
| ------------------------ | ------------------------------ |
| `SUPER + Return`         | Open terminal (Ghostty)        |
| `SUPER + Q`              | Close focused window           |
| `SUPER + Space`          | Launch application menu (Walker) |
| `SUPER + L`              | Lock screen (Hyprlock)         |
| `SUPER + E`              | Open file manager (Nautilus)   |
| `SUPER + H/J/K/L`        | Navigate windows (vim-style)   |
| `SUPER + 1-4`            | Switch to workspace 1-4        |
| `SUPER + SHIFT + 1-4`    | Move window to workspace 1-4   |

---