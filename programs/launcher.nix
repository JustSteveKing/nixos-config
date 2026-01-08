{ pkgs, ... }:

{
  home.packages = [ pkgs.hyprlauncher ];

  home.file.".config/hypr/hyprlauncher.conf".text = ''
    hover_color = rgba(89b4faff)
    text_color = rgba(cdd6f4ff)
    main_color = rgba(1e1e2eff)
    border_color = rgba(89b4faff)
  '';
}
