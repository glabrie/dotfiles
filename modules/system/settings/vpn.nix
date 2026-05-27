{ ... }:
{
  flake.modules.nixos.vpn =
  { config, ... }:
  {
    age.secrets.protonvpn-privkey = {
      file = ../../../secrets/protonvpn-privkey.age;
      mode = "0400";
    };

    networking.wg-quick.interfaces.protonvpn = {
      address = [ "10.2.0.2/32" "2a07:b944::2:2/128" ];
      dns = [ "10.2.0.1" "2a07:b944::2:1" ];
      privateKeyFile = config.age.secrets.protonvpn-privkey.path;
      peers = [
        {
          publicKey = "aQ2NoOYEObG9tDMwdc4VxK6hjW+eA0PLfgbH7ffmagU=";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "146.70.198.2:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
