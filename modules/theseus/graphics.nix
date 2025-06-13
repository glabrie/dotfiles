# graphics.nix - Configuration for NVIDIA Optimus laptop
{ config, lib, pkgs, ... }:

{
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
#    driSupport = true;
    driSupport32Bit = true;  # Needed for Steam and other 32-bit applications
    extraPackages = with pkgs; [
      intel-media-driver  # VAAPI driver for Intel iGPU
      vaapiIntel          # VAAPI for older Intel iGPUs
      vaapiVdpau
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
      finegrained = true;  # For Turing or newer GPUs
    };
    
    # Use the NVidia open source kernel module (for newer cards)
    # Comment this out if you have an older NVIDIA GPU
    open = true;
    
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
    
    # Enable DRM kernel mode setting
    # This helps with Wayland compatibility
    forceFullCompositionPipeline = true;
  };

  # For GNOME - ensure gdm uses wayland
  #  services.xserver.displayManager.gdm = {
  #  wayland = true;
    # If you have issues with wayland, set this to false
    # wayland = false;
  # };
  
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
  ];

  # For hybrid graphics - set the default to the integrated GPU for better battery life
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD"; # Use Intel's media driver for hardware video acceleration
  };
}
