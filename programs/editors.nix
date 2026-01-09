{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    package = pkgs.vscode;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
	github.copilot

        astro-build.astro-vscode


      ];

      userSettings = {
        "window.menuBarVisibility" = "toggle";
        "terminal.integrated.defaultProfile.linux" = "bash";
        # Tip: Add this to hide the "Profiles" badge if you only use one
        "workbench.settings.editor" = "json";
      };
    };

  };
}
