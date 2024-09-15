{ config, pkgs, ... }:
let 
  myHome = config.home.homeDirectory;
in
  {
  accounts.calendar = {
    basePath = "${myHome}/.calendar";
    accounts.home.khal = {
      enable = true;
      type = "calendar";
      addresses = [
        "rachitverma1122@gmail.com"
      ];
      color = "light green";
    };
  };

  programs.khal = {
    enable = true;
    package = pkgs.khal;
    settings = {
      default = {
        default_calendar = "home";
        timedelta = "5d";
      };
      view = {
        agenda_event_format = "{calendar-color}{cancelled}{start-end-time-style} {title}{repeat-symbol}{reset}";
      };
    };
  };
}
