{ pkgs, ... }:
{
  flake.modules.nixos.nightly-update =
  { pkgs, ... }:
  {
    systemd.services.nightly-update = {
      description = "Nightly flake update and rebuild";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "nightly-update" ''
          set -e
          ${pkgs.nix}/bin/nix flake update /home/ghil/.dotfiles
          ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake /home/ghil/.dotfiles#theseus
          ${pkgs.systemd}/bin/systemctl suspend
        '';
      };
    };

    systemd.timers.nightly-update = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 04:00:00";
        WakeSystem = true;
        Persistent = true;
      };
    };
  };
}
