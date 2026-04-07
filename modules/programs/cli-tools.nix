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
      direnv
      eza #best replacement for ls
      file
      fzf
      gcc
      git
      gh
      mpc
      nmap
      shotwell
      yazi
      zellij
    ];
  };
}
