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
    # for terminal opening in Thunar and other stuff
    terminal-exec = {
      enable = true;
      settings = {
        default = [
          "kitty.desktop"
        ];
      };
    };
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
