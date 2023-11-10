{ config, pkgs, ... }:

{
  # Add user to libvirtd group
  users.users.benny.extraGroups = [ "vboxusers" ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;

}
