{ config, pkgs, ... }:
let
  themix = config.colorScheme.palette;
in

{
  programs.wofi = {
    enable = true;

    package = pkgs.wofi;

    settings = {
      width = 600;
      height = 500;
      location = "center";
      show = "drun";
      prompt = "Apps";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };

    style = # scss
      ''

        * {
            font-family: 'Iosevka Nerd Font';
            font-size: 14px;
          }
          
          /* Window */
          window {
            margin: 0px;
            padding: 10px;
            border: 0.16em solid #${themix.base09};
            border-radius: 0.1em;
            background-color: #${themix.base00};
            animation: slideIn 0.5s ease-in-out both;
          }
          
          /* Slide In */
          @keyframes slideIn {
            0% {
               opacity: 0;
            }
          
            100% {
               opacity: 1;
            }
          }
          
          /* Inner Box */
          #inner-box {
            margin: 5px;
            padding: 10px;
            border: none;
            background-color: #${themix.base00};
            animation: fadeIn 0.5s ease-in-out both;
          }
          
          /* Fade In */
          @keyframes fadeIn {
            0% {
               opacity: 0;
            }
          
            100% {
               opacity: 1;
            }
          }
          
          /* Outer Box */
          #outer-box {
            margin: 5px;
            padding: 10px;
            border: none;
            background-color: #${themix.base00};
          }
          
          /* Scroll */
          #scroll {
            margin: 0px;
            padding: 10px;
            border: none;
            background-color: #${themix.base00};
          }
          
          /* Input */
          #input {
            margin: 5px 20px;
            padding: 10px;
            border: none;
            border-radius: 0.1em;
            color: #${themix.base05};
            background-color: #${themix.base00};
            animation: fadeIn 0.5s ease-in-out both;
          }
          
          #input image {
              border: none;
              color: #${themix.base08};
          }
          
          #input * {
            outline: 4px solid #${themix.base08}!important;
          }
          
          /* Text */
          #text {
            margin: 5px;
            border: none;
            color: #${themix.base05};
            animation: fadeIn 0.5s ease-in-out both;
          }
          
          #entry {
            background-color: #${themix.base00};
          }
          
          #entry arrow {
            border: none;
            color: #${themix.base09};
          }
          
          /* Selected Entry */
          #entry:selected {
            border: 0.11em solid #${themix.base09};
          }
          
          #entry:selected #text {
            color: #${themix.base0E};
          }
          
          #entry:drop(active) {
            background-color: #${themix.base09}!important;
          }
      '';
  };
}
