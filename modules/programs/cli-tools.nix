{ inputs, ... }:
{
  flake.modules.nixos.cli-tools =
  { pkgs, ... }:
  {
    environment.systemPackages = with pkgs;
    [
      arp-scan
      p7zip
      bottom
      cliphist
      cmake
      fastfetch
      file
      fzf
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
      zellij
      inputs.concord.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  };
}
