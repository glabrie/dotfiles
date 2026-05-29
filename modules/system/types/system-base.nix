# Definition of a minimal system upon which we can build of. Currently supports only nixOS.
{ inputs, ... }:
{
  flake.modules.nixos.system-base =
  { pkgs, ... }:
  {
    imports = [
      inputs.self.modules.nixos.cli-tools
      inputs.agenix.nixosModules.default
    ];

    # I know Stallman wouldn't approve. I don't care.
    nixpkgs.config.allowUnfree = true;

    # For the love of all that is holy do not touch. Yes, even if you update to a new version. I know.
    system.stateVersion = "25.11";

    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };

    nix.settings = {
      # enable the flake "experimental" feature, needed for the config to work.
      experimental-features = [ "nix-command" "flakes" ];
      download-buffer-size = 524288000;
    };

    # Because I hate useless warnings. I know, I'll commit it after I know it works.
    nix.extraOptions = ''
      warn-dirty = false
      keep-outputs = true
    '';

    nix.channel.enable = false;
  };

  flake.modules.homeManager.system-base =
  { config, ... }:
  {
    home.homeDirectory = "/home/${config.home.username}";
    home.stateVersion = "25.11";
  };
}
