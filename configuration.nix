# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # For creating a KVM hypervisor
    # ./libvirt.nix

    # For creating a virtualbox hypervisor
    ./virtualbox.nix

    # For installing podman
    ./podman.nix

    # For creating a bridge interface (e.g. with libvirt.nix)
    # ./bridge.nix
  ];

  #########################
  # System
  #########################

  # Bootloader for systemd (default)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Bootloader for grub in a virtual block device
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/vda";
  # boot.loader.grub.useOSProber = true;

  networking.hostName = "MCHV01"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Australia/Darwin";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable programs
  programs = {
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "gtk2";
    };
  };

  # Enable Terminus nerdfont
  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["Terminus"];})
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  #########################
  # services
  #########################

  # Define primary services
  services = {
    openssh.enable = true;
    xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      layout = "au";
      enable = true;
      xkbVariant = "";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  #########################
  # users
  #########################

  users.users.benny = {
    isNormalUser = true;
    description = "Defalt User";
    initialPassword = "changeme";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINdP/kUVRxxCLk5GlBI6GUfUPruy/EnSoFRBZ+Qi95gv benny@MCWS02"];
  };

  #########################
  # applications
  #########################

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    chromium
    firefox
    gcc
    git
    git-crypt
    gimp
    htop
    lazygit
    libreoffice
    nmap
    pass
    pinentry
    python39
    spotify
    thunderbird
    tldr
    unzip
    viewnior
    virt-manager
    wget
    wl-clipboard
  ];

  # don't touch
  system.stateVersion = "23.05";
}
