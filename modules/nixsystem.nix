{
  nix = {

    optimise = {
      automatic = true;
      dates = [ "10:45" ];
    };

    # Enable experimental features
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      cores = 8; # Decrease it for lesser heat and low RAM consumption when building a flake
      max-jobs = 1; # Keep it low for parallel jobs

      substituters = [
        # See ./desktop.nix
        "https://hyprland.cachix.org" # Hyprland cachix for all dependencies 
      ];
      trusted-public-keys = [
        # for Hyprland config, see home-manager and ./desktop
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" # Hyprland cachix for all dependencies
      ];
    };

    # Enable space optimisation by setting automatic deletion of older generations
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 4d";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
