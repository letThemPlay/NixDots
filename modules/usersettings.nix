{ pkgs, ... }:

{
  users.users.chris = {
    initialPassword = "123";
    isNormalUser = true;
    extraGroups = [ 
      "wheel"
      "input"
      "video"
      "networkmanager"
      "adbusers" # To use the andorid debugging tools
    ];
    shell = pkgs.zsh;
  };

  # The xdg settings are in ./home/xdgSettings.nix
  xdg = {
    portal = {
      enable = true;
      wlr = {
        enable = true;
      };
    };
  };

  # enable user level programs here
  programs.zsh.enable = true;
}
