{ inputs, ... }:
{
  flake.modules.nixos.cli-tools =
  { pkgs, ... }:
  {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/ghil/.dotfiles";
    };

    environment.systemPackages = with pkgs;
    [
      comma
      nix-index
      arp-scan
      p7zip-rar
      bottom
      cliphist
      cmake
      fastfetch
      file
      fzf
      jujutsu
      gcc
      git
      gh
      mpc
      mpv
      ncdu
      neovim
      nmap
      rmpc
      ripgrep
      shotwell
      yazi
      yt-dlp

      inputs.concord.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  };
}
