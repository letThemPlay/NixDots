{ pkgs, ... }:
{
  programs = {

    # Enable fastfetch
    fastfetch = {
      enable = true;
      package = pkgs.fastfetch;
    };

    # Enable Zathura pdf reader
    zathura = {
      enable = true;
      package = pkgs.zathura;
    };
    
    # Enable btop for system monitor
    btop = {
      enable = true;
      package = pkgs.btop;

      settings = {
        color_theme = "gruvbox_dark_v2";
        theme_background = false;
      };
    };
  };

  # Other packages
  home = {
    packages = with pkgs;[
      qbittorrent
    ];

    # Source some files here
    file = {
      ".config/btop/themes/" = {
        source = ./../Themes/btop;
        recursive = true;
      };
    };
  };

  # Service based programs
  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
