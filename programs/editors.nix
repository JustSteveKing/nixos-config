{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      github.copilot
      anthropic.claude-dev
    ];

    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "editor.fontFamily" = "'JetBrains Mono', 'monospace'";
      "editor.fontSize" = 12;
      "window.menuBarVisibility" = "toggle";
      "terminal.integrated.defaultProfile.linux" = "bash";
    };
  };
}
