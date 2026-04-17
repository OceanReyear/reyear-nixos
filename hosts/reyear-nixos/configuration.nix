{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.11";
  networking.hostName = "reyear-nixos";
  networking.networkmanager.enable = true;

  users.users.reyear = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    # Set password after first boot from root/sudo, e.g. run `passwd reyear`.
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
