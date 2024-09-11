{pkgs, ...}:
{
  programs.wlogout = {
    enable = true;
    package = pkgs.wlogout;
  };
}
