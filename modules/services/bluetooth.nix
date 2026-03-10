# bluetooth config.
{ ...}:
{
  flake.modules.nixos.bluetooth = 
  { ... }:
  {
    # Enable bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General = {
        Privacy = "device";
        JustWorksRepairing = "always";
        Class = "0x000100";
        FastConnectable = true;
      };
    };
    # Bluetooth applet
    services.blueman.enable = true;
  };
}
