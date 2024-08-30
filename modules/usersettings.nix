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
}
  
