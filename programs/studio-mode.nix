{ pkgs, ... }:

let
  studio-toggle = pkgs.writeScriptBin "studio-toggle" ''
    #!/bin/bash
    if [ ! -f /tmp/studio_mode ]; then
        touch /tmp/studio_mode
        makoctl mode -a do-not-disturb
        hyprctl keyword general:col.active_border "rgba(f38ba8ff) 45deg"
        pkill -USR1 waybar # Hides waybar
        notify-send "Studio Mode" "Recording environment active. UI hidden."
    else
        rm /tmp/studio_mode
        makoctl mode -r do-not-disturb
        hyprctl reload # Restores your Catppuccin borders
        pkill -USR1 waybar # Shows waybar
        notify-send "Studio Mode" "Back to standard mode."
    fi
  '';
in
{
  home.packages = [ studio-toggle ];
}
