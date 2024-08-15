{ pkgs, lib, ... }:

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
        use = "gruvbox-dark";
      };
    };
  };
  home.file.".config/yazi/flavors/gruvbox-dark.yazi" = {
    recursive = true;
    source = ./yazi_config/gruvbox-dark.yazi;
  };

  # Enable some programs for working with yazi
  programs = {
    fd.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
    fzf.enable = true;
    zoxide.enable = true;
  };
  
  home.packages = with pkgs;[ 
    android-file-transfer

    ffmpegthumbnailer
    unrar
    poppler
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
