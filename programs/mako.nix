{ pkgs, ... }:

{
  services.mako = {
    enable = true;
    # Move the behavior/layout settings into this block
    settings = {
      anchor = "top-right";
      margin = "20,20";
      padding = "15";
      border-size = 2;       # Note the change from camelCase to kebab-case
      border-radius = 10;
      default-timeout = 5000;
      ignore-timeout = false;
      max-visible = 3;
      layer = "overlay";
    };
    
    # Progress bar and specific overrides stay in extraConfig
    extraConfig = ''
      progress-color=#89b4fa
      
      [urgency=high]
      border-color=#f38ba8
      default-timeout=0
    '';
  };
}
