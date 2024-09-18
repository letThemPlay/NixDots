{ pkgs, ... }:
let
  theme = "gruvbox-dark";
in 
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;

    shellWrapperName = "yy";
    settings = {
      opener = {
        edit = [
          {
            block = true;
            run = "vim  \"$@\"";
          }
        ];
        play = [
          {
            run = "vlc \"$@\"";
            orphan = true;
            for = "unix";
          }
        ];

        zathura-open = [
          {
            run = "zathura \"$@\"";
            orphan = true;
          }
        ];
      };

      open = {
        prepend_rules = [
          {
            name = "*.pdf";
            use = "zathura-open";
          }
        ];
      };
    };

    keymap = {
      manager = {
        prepend_keymap = [
           # For mounting phone or mtp devices
          {
            on = [ "b" "m" ];
            run = "shell --interactive \"aft-mtp-mount ~/myDevice/\"";
            desc = "Mount phone device";
          }

          # For unmounting phone devices
          {
            on = [ "b" "u" ];
            run = "shell --interactive \"kitty -e sudo umount -R ~/myDevice\"";
            desc = "Unmount the phone";
          }

          # For going into the directory of usb media (see udiskie)
          {
            on = [ "g" "m" ];
            run = "cd /run/media";
            desc = "Go into mounted USB media";
          }
        ];
      };
    };
    theme = {
      flavor = {
        use = "${theme}";
      };
    };
  };
  home.file.".config/yazi/flavors/${theme}.yazi" = {
    recursive = true;
    source = ./../Themes/yazi/${theme}.yazi;
  };
  
  home.packages = with pkgs;[ 
    android-file-transfer

   # ffmpegthumbnailer
   # unrar
   # poppler
  ];

  # Enable udiskie and other services here to mount the usb pendrive
  services = {
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
    };
  };
}
