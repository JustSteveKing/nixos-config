{
  powerManagement.cpuFreqGovernor = "performance";

  hardware.cpu.amd.updateMicrocode = true;

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

  # Graphics / Video Acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.keyboard.zsa.enable = true;
}
