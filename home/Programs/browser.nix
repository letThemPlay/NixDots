{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    nativeMessagingHosts = with pkgs; [
      uget-integrator
    ];
    profiles.chris = {
      name = "Chris";
    };
  };

  home.packages = with pkgs; [ uget ];
}
