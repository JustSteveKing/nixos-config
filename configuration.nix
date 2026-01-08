{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1
  '';

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "btusb.enable.autosuspend=n"
    "pcie_aspm=off"
  ];


  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
	FastConnectable = true;
      };
    };
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Graphics / Video Acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };


  # Clean TTY-based login instead of GDM
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-hyprland";
        user = "steve";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVDisallocate = true;
  };

  # Configure keymap
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    xkb = {
      layout = "gb";
      variant = "";
    };
  };
  console.keyMap = "uk";

  # Sound and Bluetooth
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.steve = {
    isNormalUser = true;
    description = "Steve McDougall";
    extraGroups = [ "networkmanager" "wheel" "plugdev" ];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    tuigreet
    keymapp # For your Moonlander
  ];

  services.openssh.enable = true;
  services.ollama = {
    enable = true;
    loadModels = [ "deepseek-r1:1.5b" "llama3.2" ];
  };

  services.dbus.packages = [ pkgs.blueman ];

  services.blueman.enable = true;

  hardware.keyboard.zsa.enable = true;
  system.stateVersion = "24.11";
}
