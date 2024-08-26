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
    ];
    shell = pkgs.zsh;
  };
}
  
