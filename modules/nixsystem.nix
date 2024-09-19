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
