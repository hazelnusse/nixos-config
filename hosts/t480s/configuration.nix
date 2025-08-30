{ config, pkgs, inputs, ... }:

{
  boot = {
    initrd.luks.devices."luks-b192e13e-bebb-45ba-a82b-af659fcc23fc".device = "/dev/disk/by-uuid/b192e13e-bebb-45ba-a82b-af659fcc23fc";
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "luke" = import ./home.nix;
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  networking.networkmanager.enable = true;
  networking.hostName = "t480s";

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config.allowUnfree = true;

  # I don't know why, but this doesn't work in the programs section of home.nix
  programs.nix-ld.enable = true;

  # rtkit is needed with pipewire.
  security.rtkit.enable = true;

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.dates = "weekly";
    # Do not change.
    stateVersion = "24.11";
  };

  time.timeZone = "America/Los_Angeles";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.luke = {
    description = "Luke";
    extraGroups = [ "networkmanager" "wheel" ];
    isNormalUser = true;

    # zsh is installed via home manager
    ignoreShellProgramCheck = true;
    shell = pkgs.zsh;
  };
}
