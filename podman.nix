{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    podman-compose
  ];

  # Manage podman service
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;  # Enable docker alias
      defaultNetwork.settings = {
        dns_enabled = true;  # Required for podman-compose
      };
    };
  };

  # Allow podman to run on unprivileged ports starting at 53
  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 53;
  };
}
