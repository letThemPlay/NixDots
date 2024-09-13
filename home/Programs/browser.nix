{ pkgs, ... }:

{
  programs = {
    qutebrowser = {
      enable = true;
      package = pkgs.qutebrowser;
      searchEngines = {
        nw = "https://mynixos.com/";
        g = "https://www.google.com/";
      };
      quickmarks = {
        manageHome = "https://nix-community.github.io/home-manager/options.xhtml";
      };
      loadAutoconfig = true;
      enableDefaultBindings = true;
      extraConfig = ''
      '';
    };

    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
      nativeMessagingHosts = with pkgs; [
        uget-integrator
      ];
      profiles.chris = {
        name = "Chris";

        bookmarks = [
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "store";
                url = "https://mynixos.com/";
              }
              {
                name = "homedix";
                url = "https://nix-community.github.io/home-manager/options.xhtml";
              }
              {
                name = "sysdix";
                url = "https://nixos.org/manual/nixos/stable/options";
              }
            ];
          }
        ];
      };
    };
  };
  home.packages = with pkgs; [ uget ];
}
