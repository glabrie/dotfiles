# Nix specific settings. 

{ ... }:
{
  flake.modules.nixos.nix =
  { ... }:
  {
    # enable the flake "experimental" feature, needed for the config to work.
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Fix the buffer size, reducing rebuild time by allowing a bigger download throughput, 
    # at the tradeoff of more RAM usage. 
    # In this economy?!?
    nix.settings.download-buffer-size = 524288000;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # nh, because I like my fingies
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/ghil/.dotfiles/";
    };
  };
}
