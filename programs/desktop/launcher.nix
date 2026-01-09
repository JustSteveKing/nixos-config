{ inputs, pkgs, ... }:

{
  imports = [ inputs.walker.homeManagerModules.default ];

  programs.walker = {
    enable = true;

    runAsService = true;

    config = {

      search.placeholder = "Search apps, files, or calculations ...";
      ui.fullscreen = false;
      list = {
        height = 300;
      };

      websearch.prefix = "?";
      switcher.prefix = "/";
    };
  };
}
