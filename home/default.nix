{ config, lib, pkgs,  inputs,  ... }:
let
  nixGLIntel = inputs.nixGL.packages.${pkgs.system}.nixGLIntel.wrap;
in
{
    imports = [
       ./programs/tmux.nix 
       ./programs/git.nix
       ./programs/nixvim.nix
       ./programs/zellij.nix
       ./programs/bash.nix
       ./programs/starship.nix
       ./programs/hyprland.nix
       ./programs/nixgl.nix

       (builtins.fetchurl {
        url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
        sha256 = "1krclaga358k3swz2n5wbni1b2r7mcxdzr6d7im6b66w3sbpvnb3";
        })
	    ];

  # nixGL.prefix = "${nixGLIntel}/bin/nixGLIntel";

  home.username = "marchel";
  home.homeDirectory = "/home/marchel";

  home.stateVersion = "24.05"; # Please read the comment before changing.
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      };
    };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    neofetch
    bat
    tree
    unzip
    vim
    curl
    git
    unzip
    vlc
    libreoffice-qt
    (config.lib.nixGL.wrap kitty)

    # brave
    
    # Waybar stuff:
    font-awesome # Needed for waybar icons
    networkmanagerapplet
    brightnessctl # Commandline brightness controll
    wttrbar # For weather info
    blueberry # Bluetooth config tool
    playerctl # For music controll
    swappy # Screenshot edit tool 
    sway-contrib.grimshot # Screenshot tool
    grimblast # screenshot tool
    slurp

    # Hyprland stuff
    libva # screenshare testing
    libsForQt5.qt5.qtwayland # screenshare testing
    qt6.qtwayland # screenshare testing
    adwaita-qt6 # screenshare testing
    bibata-cursors  
    hicolor-icon-theme
    gtk-layer-shell
    libsForQt5.polkit-kde-agent

    nwg-launchers
    nwg-bar
    wofi
    nwg-drawer
    swaybg
    wlsunset
    swaylock-effects
    swayidle
    hyprpaper
    wl-clipboard
    clipman # wayland clipboard manager
    hyprpicker
    swaynotificationcenter      
    pavucontrol

    ripdrag # drag files from terminal
    ydotool # key automation tool

    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    #rust
    rustup
    sqlx-cli

    #js
    nodejs_22
    deno
    bun

    # android-studio

  ];

  # Fix for some XDG path issues:
  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
  '';
  xdg.enable=true;
  xdg.mime.enable=true;
  targets.genericLinux.enable=true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications"  "${config.home.homeDirectory}/.nix-profile/share/" ];

  ## GTK theme stuff
  home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Amber";
      size = 24;
  };
  gtk = {
      enable = true;
      theme = {
          package = pkgs.flat-remix-gtk;
          name = "Flat-Remix-GTK-Grey-Darkest";
      };
      iconTheme = {
          package = pkgs.libsForQt5.breeze-icons;
          name = "breeze-dark";
      };
      # font = {
      #     name = "Sans";
      #     size = 10;
      # };
  };  

  home.file = {};

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

      programs.home-manager.enable = true;
}
