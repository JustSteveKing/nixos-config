{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "HDMI-A-1, 2256x1504, 0x0, 1.33";

      input = {
        kb_layout = "us"; # Matches your console setting [cite: 33]
        follow_mouse = 1;
        touchpad.natural_scroll = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
      };

      # Set your preferred programs
      "$terminal" = "ghostty";
      "$fileManager" = "nautilus";
      "$menu" = "walker";

      "$mod" = "SUPER";

      bind = [
        # Terminal and Apps
        "$mod, Return, exec, $terminal" # This replaces the kitty default
        "$mod, Q, killactive," # Close focused window
        "$mod, Space, exec, $menu"
        "$mod, F, exec, firefox"
        "$mod, E, exec, $fileManager"
        "$mod, C, exec, code"
        "$mod, V, togglefloating,"
        "$mod, O, exec, obs"
        "$mod, S, exec, studio-toggle"
        "$mod, M, exit," # Logout of Hyprland
        "$mod, L, exec, hyprlock"


        # Vim-style Focus Movement (HJKL)
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Workspace switching
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"

        # Move active window to workspaces
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"

        # Framework 13 / Moonlander Media Keys
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      exec-once = [
        "waybar"
        "blueman-applet"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "walker --gapplication-service"
      ];
    };
  };

  home.packages = with pkgs; [
    waybar
    wl-clipboard
    blueman
  ];

}
