{ config, pkgs, ... }:

{
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

  console.keyMap = "us";
}
