{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
  };

  home.packages = with pkgs; [ uget uget-integrator ];
}
