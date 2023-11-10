{ config, pkgs, ... }:

{
  # For turning an interface into a bridge for KVM vms
  networking.useDHCP = false;
  networking.bridges = {
    "br0" = {
      interfaces = [ "eno1" ];
    };
  };
  networking.interfaces.br0.ipv4.addresses = [ {
    address = "192.168.1.15";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "192.168.1.40";
  networking.nameservers = ["8.8.8.8" "1.1.1.1"];

}
