# Definition of a minimal system upon which we can build of. Currently supports only nixOS.
{ inputs, ... }:
{
  flake.modules.nixos.system-base = 
  { pkgs, ... }:
  {
    imports =
      with inputs.self.modules.nixos;
      [
        cli-tools
        firmware
        home-manager
        zsh
      ];
    
    # I know Stallman wouldn't approve. I don't care.
    nixpkgs.config.allowUnfree = true;

    # For the love of all that is holy do not touch. Yes, even if you update to a new version. I know.
    system.stateVersion = "25.11";

    nix.settings = {
      
      # enable the flake "experimental" feature, needed for the config to work.
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    # Because I hate useless warnings. I know, I'll commit it after I know it works.
    nix.extraOptions = ''
      warn-dirty = false
      keep-outputs = true
    '';
    
    # Fix the buffer size, reducing rebuild time by allowing a bigger download throughput, 
    # at the tradeoff of more RAM usage. 
    # In this economy?!?
    nix.settings.download-buffer-size = 524288000;
  };

  flake.modules.homeManager.system-base =
  { config, ... }:
  {
    imports = with inputs.self.modules.homeManager;
    [
      mpd
      starship
      zsh
    ];

    home.homeDirectory = "/home/${config.home.username}";
    home.stateVersion = "25.11";
    home.sessionVariables = {
      EDITOR = "emacsclient -t";
      };
  };
}
