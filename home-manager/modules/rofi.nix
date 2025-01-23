{ pkgs, config, ... }:
{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-calc
    ];
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };
  home.file.".config/rofi/themes/custom.rasi".text = ''
    * {
        font:   "IBM Plex Mono 12";

        nord0:     #2e3440;
        nord1:     #3b4252;
        nord2:     #434c5e;
        nord3:     #4c566a;

        nord4:     #d8dee9;
        nord5:     #e5e9f0;
        nord6:     #eceff4;

        nord7:     #8fbcbb;
        nord8:     #88c0d0;
        nord9:     #81a1c1;
        nord10:    #5e81ac;
        nord11:    #bf616a;

        nord12:    #d08770;
        nord13:    #ebcb8b;
        nord14:    #a3be8c;
        nord15:    #b48ead;

        background-color:   transparent;
        text-color:         @nord4;
        accent-color:       @nord8;

        margin:     0px;
        padding:    0px;
        spacing:    0px;
    }
    window {
        background-color:   @nord0;
        border-color:       @accent-color;

        location:   center;
        width:      480px;
        border:     1px;
    }

    inputbar {
        padding:    8px 12px;
        spacing:    12px;
        children:   [ prompt, entry ];
    }

    prompt, entry, element-text, element-icon {
        vertical-align: 0.5;
    }

    prompt {
        text-color: @accent-color;
    }

    listview {
        lines:      8;
        columns:    1;

        fixed-height:   true;
    }

    element {
        padding:    8px;
        spacing:    8px;
    }

    element normal urgent {
        text-color: @nord13;
    }

    element normal active {
        text-color: @accent-color;
    }

    element alternate active {
        text-color: @accent-color;
    }

    element selected {
        text-color: @nord0;
    }

    element selected normal {
        background-color:   @accent-color;
    }

    element selected urgent {
        background-color:   @nord13;
    }

    element selected active {
        background-color:   @nord8;
    }

    element-icon {
        size:   0.75em;
    }

    element-text {
        text-color: inherit;
    }
  '';
}
