# CLI tools needed on every system.
{ ... }:
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
      direnv
      fastfetch
      file
      fzf
      gcc
      git
      gh
      mpc
      ncdu
      nmap
      ripgrep
      shotwell
      yazi
      zellij
    ];
  };
}
