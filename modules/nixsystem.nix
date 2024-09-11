{
  nix = {

    optimise = {
      automatic = true;
      dates = [ "03:45" ];
    };

    # Enable experimental features
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      cores = 8;
      max-jobs = 2;
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
