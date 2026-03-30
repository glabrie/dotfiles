# graphics.nix - Configuration for NVIDIA Optimus laptop
{ ... } :
{
  flake.modules.nixos.nvidia =
    { config, pkgs, ... }:
    {
      # Enable OpenGL
      hardware.graphics = {
        enable = true;
        # driSupport = true;
        enable32Bit = true;  # Needed for Steam and other 32-bit applications
        extraPackages = with pkgs; [
          intel-media-driver  # VAAPI driver for Intel iGPU
          intel-vaapi-driver  # VAAPI for older Intel iGPUs
          libva-vdpau-driver
          libvdpau-va-gl
        ];
      };

      # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        # Modesetting is required for Wayland
        modesetting.enable = true;
        
        # Enable power management (important for laptops to save battery)
        powerManagement = {
          enable = true;
          finegrained = false;  # Requires Turing (RTX 20xx)+; GTX 1050 is Pascal
        };
        
        # Use the NVidia open source kernel module (for newer cards)
        # Comment this out if you have an older NVIDIA GPU
        open = false;
        
        # Enable the Optimus Prime offloading mode
        prime = {
          offload.enable = true;
          
          # Intel iGPU as primary
          intelBusId = "PCI:0:2:0";  # You might need to verify this with `lspci | grep VGA`
          
          # NVIDIA dGPU
          nvidiaBusId = "PCI:1:0:0";  # You might need to verify this with `lspci | grep NVIDIA`
        };
        
        # Enable the nvidia-settings menu
        nvidiaSettings = true;
      };

      # Add nvidia-offload script for easy launching of applications on the NVIDIA GPU
      environment.systemPackages = with pkgs; [
        # Create a script to easily run programs on the NVIDIA GPU
        (writeShellScriptBin "nvidia-offload" ''
          export __NV_PRIME_RENDER_OFFLOAD=1
          export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
          export __GLX_VENDOR_LIBRARY_NAME=nvidia
          export __VK_LAYER_NV_optimus=NVIDIA_only
          exec "$@"
        '')
      ];

      # Add kernel parameters to improve NVIDIA compatibility and performance
      boot.kernelParams = [
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"  # Better suspend/resume support
        "video=eDP-1:d"  # Disable internal display at KMS level (eDP-1 is on Intel/card0, unmanaged by Hyprland)
        "nvidia.NVreg_RegistryDwords=PowerMizerEnable=0x1;PowerMizerDefault=0x1;PowerMizerDefaultAC=0x1;PerfLevelSrc=0x2222" # Power mizer setting to force the clock, for niri.
      ];

      environment.etc."nvidia/nvidia-application-profiles-rc.d/50-niri-vram-fix.json".text =
      builtins.toJSON {
        rules = [
          {
            pattern = {
              feature = "procname";
              matches = "niri";
            };
            profile = "Limit Free Buffer Pool On Wayland Compositors";
          }
        ];
        profiles = [
          {
            name = "Limit Free Buffer Pool On Wayland Compositors";
            settings = [
              {
                key = "GLVidHeapReuseRatio";
                value = 0;
              }
            ];
          }
        ];
      };

      # For hybrid graphics - set the default to the integrated GPU for better battery life
      environment.variables = {
        LIBVA_DRIVER_NAME = "iHD"; # Use Intel's media driver for hardware video acceleration
        NIXOS_OZONE_WL = "1";
      };
    };
}
