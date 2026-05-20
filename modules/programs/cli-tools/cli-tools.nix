{ inputs, ... }:
{
  flake.modules.nixos.cli-tools =
  { pkgs, ... }:
  {
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
    ];

  };
}
