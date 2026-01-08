{ pkgs, ... }:

{
  home.packages = with pkgs; [

    (writeShellScriptBin "claude" ''
      export PATH="${pkgs.nodejs_20}/bin:$PATH"
      npx -y @anthropic-ai/claude-code "$@"
    '')

    gh-dash
    aider-chat
  ];

  home.sessionVariables = {
    CLAUDE_EDITOR = "nvim";
  };

  home.shellAliases = {
    "cc" = "claude";
    "ask" = "claude --once p";
  };
}
