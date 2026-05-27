{ ... }:
{
  flake.modules.nixos.kanata =
  { lib, ... }:
  {
    hardware.uinput.enable = true;
    users.groups.uinput = { };
    services.kanata = {
      enable = true;
      keyboards.kanata = {
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
            a   s   d   f   j   k   l   ;
          )
          (defvar
            tap-time 150
            hold-time 120

            left-hand-keys (
              q w e r t
              a s d f g
              z x c v b
            )
            right-hand-keys (
              y u i o p
              h j k l ;
              n m , . /
            )
          )
          (deflayer base
            @a  @s  @d  @f  @j  @k  @l  @;
          )
          (deflayer nomods
            a   s   d   f   j   k   l   ;
          )
          (deffakekeys
            to-base (layer-switch base)
          )
          (defalias
            tap (multi
              (layer-switch nomods)
              (on-idle-fakekey to-base tap 20)
            )

            a (tap-hold-release-keys $tap-time $hold-time (multi a @tap) lmet $left-hand-keys)
            s (tap-hold-release-keys $tap-time $hold-time (multi s @tap) lalt $left-hand-keys)
            d (tap-hold-release-keys $tap-time $hold-time (multi d @tap) lctl $left-hand-keys)
            f (tap-hold-release-keys $tap-time $hold-time (multi f @tap) lsft $left-hand-keys)
            j (tap-hold-release-keys $tap-time $hold-time (multi j @tap) rsft $right-hand-keys)
            k (tap-hold-release-keys $tap-time $hold-time (multi k @tap) rctl $right-hand-keys)
            l (tap-hold-release-keys $tap-time $hold-time (multi l @tap) ralt $right-hand-keys)
            ; (tap-hold-release-keys $tap-time $hold-time (multi ; @tap) rmet $right-hand-keys)
          )
        '';
      };
    };
    systemd.services.kanata-kanata.serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = lib.mkForce "ghil";
      PrivateUsers = lib.mkForce false;
    };
  };
}
