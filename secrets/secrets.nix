let
  ghil = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBV9vWWWG5h/Lg9ar+6Qena77JtMELm0xbO8BaqwI46Z ghil@theseus";
  zeno = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPnChXG1gKphCvbsKbNEMDlVo8XtAaICHrUcFD4+CnV";
  theseus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL+sqqnbr9fHGb43ui5XqqTunX4ni3xU48aYMtOj3Gnl root@theseus";
in
{
  "namecheap-acme.age".publicKeys = [ ghil zeno ];
  "protonvpn-privkey.age".publicKeys = [ ghil theseus ];
}
