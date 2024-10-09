{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

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

      plugin = { # See plugins below
        prepend_previewers = [
          {
            mime = "video/*";
            run = "video-ffmpeg";
          }

          # Epub preview settings 
          {
            mime = "application/epub+zip";
            run = "epub-preview";
          }
        ];
        prepend_preloaders = [
          {
            mime = "video/*";
            run = "video-ffmpeg";
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

    flavors = {
      catppuccin-mocha = ./Themes/Yazi/catppuccin-mocha.yazi;
    };

    theme = { # It goes with the flavors section above
      flavor = {
        use = "catppuccin-mocha";
      };
    };

    plugins = {
      video-ffmpeg = ./Themes/Yazi/video-ffmpeg.yazi;
      epub-preview = ./Themes/Yazi/epub-preview.yazi;
    };
  };

  home.packages = with pkgs;[ 
    android-file-transfer
    ffmpeg # For use with the video-ffmpeg.yazi plugin
    epub-thumbnailer # for viewing epub format files
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
