{ 
  pkgs,
  config, 
  ... 
}:
let 
  myHome = config.home.homeDirectory;
in
  {
  xdg = {
    enable = true;

    cacheHome = "${myHome}/.cache";
    configHome = "${myHome}/.config";
    dataHome = "${myHome}/.local/share";
    stateHome = "${myHome}/.local/state";

    userDirs = {
      enable = true;
      desktop = "${myHome}/Desktop";
      documents = "${myHome}/Documents";
      download = "${myHome}/Downloads";
      music = "${myHome}/Music";
      pictures = "${myHome}/Pictures";
      videos = "${myHome}/Videos";
    };

    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
      config.common.default = ["*"];
    };
  };
}
