{ pkgs, config, ... }:
let
  themix = config.colorScheme.palette;
in 

{
  programs = {
    qutebrowser = {
      enable = true;
      package = pkgs.qutebrowser;
      searchEngines = {
        nw = "https://mynixos.com/search?q={}";
        g = "https://www.google.com/search?q={}";
      };
      quickmarks = {
        manageHome = "https://nix-community.github.io/home-manager/options.xhtml";
      };
      loadAutoconfig = true;
      enableDefaultBindings = true;

      # Settings go here
      settings = {
        colors = {
          completion = {
            fg = "#${themix.base05}";
            odd.bg = "#${themix.base01}";
            even.bg = "#${themix.base00}";
            category = {
              fg = "#${themix.base0A}";
              bg = "#${themix.base00}";
              border.bottom = "#${themix.base00}";
            };

            item = {
              selected = {
                fg = "#${themix.base05}";
                bg = "#${themix.base02}";
                border = {
                  top = "#${themix.base02}";
                  bottom = "#${themix.base02}";
                };
                match.fg = "#${themix.base0B}";
              };
            };
            scrollbar = {
              fg = "#${themix.base05}";
              bg = "#${themix.base00}";
            };
          };
          contextmenu = {
            disabled = {
              bg = "#${themix.base01}";
              fg = "#${themix.base04}";
            };
            menu = {
              bg = "#${themix.base00}";
              fg = "#${themix.base05}";
            };
            selected = {
              bg = "#${themix.base02}";
              fg = "#${themix.base05}";
            };
          };
          downloads = {
            bar.bg = "#${themix.base00}";
            start = {
              fg = "#${themix.base00}";
              bg = "#${themix.base0D}";
            };
            stop = {
              fg = "#${themix.base00}";
              bg = "#${themix.base0C}";
            };
            error.fg = "#${themix.base08}";
          };
          hints = {
            bg = "#${themix.base00}";
            fg = "#${themix.base0A}";
            match.fg = "#${themix.base05}";
          };
          keyhint = {
            suffix.fg = "#${themix.base05}";
            bg = "#${themix.base00}";
            fg = "#${themix.base05}";
          };
          messages = {
            error = {
              fg = "#${themix.base00}";
              bg = "#${themix.base08}";
              border = "#${themix.base08}";
            };
            warning = {
              fg = "#${themix.base00}";
              bg = "#${themix.base0E}";
              border = "#${themix.base0E}";
            };
            info = {
              fg = "#${themix.base05}";
              bg = "#${themix.base00}";
              border = "#${themix.base05}";
            };
          };
          prompts = {
            border = "#${themix.base00}";
            bg = "#${themix.base00}";
            selected = {
              bg = "#${themix.base02}";
              fg = "#${themix.base05}";
            };
          };
          statusbar = {
            normal = {
              fg = "#${themix.base0B}";
              bg = "#${themix.base00}";
            };
            insert = {
              fg = "#${themix.base00}";
              bg = "#${themix.base0D}";
            };
            passthrough = {
              fg = "#${themix.base00}";
              bg = "#${themix.base0C}";
            };
            private = {
              fg = "#${themix.base00}";
              bg = "#${themix.base01}";
            };
            command = {
              fg = "#${themix.base05}";
              bg = "#${themix.base00}";
              private = {
                fg = "#${themix.base05}";
                bg = "#${themix.base00}";
              };
            };
            caret = {
              fg = "#${themix.base00}";
              bg = "#${themix.base0E}";
              selection = {
                fg = "#${themix.base00}";
                bg = "#${themix.base0D}";
              };
            };
            progress.bg = "#${themix.base0D}";
            url = {
              fg = "#${themix.base05}";
              error.fg = "#${themix.base08}";
              hover.fg = "#${themix.base05}";
              success = {
                http.fg = "#${themix.base0C}";
                https.fg = "#${themix.base0B}";
              };
              warn.fg = "#${themix.base0E}";
            };
          };
          tabs = {
            bar.bg = "#${themix.base00}";
            indicator = {
              start = "#${themix.base0D}";
              stop = "#${themix.base0C}";
              error = "#${themix.base08}";
            };
            odd = {
              fg = "#${themix.base05}";
              bg = "#${themix.base01}";
            };
            even = {
              fg = "#${themix.base05}";
              bg = "#${themix.base00}";
            };
            pinned = {
              even = {
                bg = "#${themix.base0C}";
                fg = "#${themix.base07}";
              };
              odd = {
                bg = "#${themix.base0B}";
                fg = "#${themix.base07}";
              };
              selected = {
                even = {
                  bg = "#${themix.base02}";
                  fg = "#${themix.base05}";
                };
                odd = {
                  bg = "#${themix.base02}";
                  fg = "#${themix.base05}";
                };
              };
            };
            selected = {
              odd = {
                fg = "#${themix.base05}";
                bg = "#${themix.base02}";
              };
              even = {
                fg = "#${themix.base05}";
                bg = "#${themix.base02}";
              };
            };
          };
          webpage.bg = "#${themix.base00}";
        };
      };
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
