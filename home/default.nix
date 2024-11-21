{ config, pkgs, ... }:
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
       ./programs/kitty.nix
       ./programs/stylix.nix

       (builtins.fetchurl {
        url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
        sha256 = "1krclaga358k3swz2n5wbni1b2r7mcxdzr6d7im6b66w3sbpvnb3";
        })
	    ];


  home.username = "marchel";
  home.homeDirectory = "/home/marchel";

  home.stateVersion = "24.05"; # Please read the comment before changing.
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      };
    };

  disabledModules = [
    "/nix/store/ipgxl36m0fp9mkwvfarfk6ypqva14fkp-source/modules/misc/nixgl.nix"
  ];

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
    nettools
    btop
    # brave
    rofi
    wl-clipboard

   
    font-awesome # Needed for waybar icons
    networkmanagerapplet
    brightnessctl # Commandline brightness controll
    blueberry # Bluetooth config tool
    swappy # Screenshot edit tool 
    sway-contrib.grimshot # Screenshot tool
    grim # screenshot tool
    slurp

    # # Hyprland stuff
    # libva # screenshare testing
    # libsForQt5.qt5.qtwayland # screenshare testing
    # qt6.qtwayland # screenshare testing
    # adwaita-qt6 # screenshare testing
    # hicolor-icon-theme
    # gtk-layer-shell
    # libsForQt5.polkit-kde-agent

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

  gtk = {
      enable = true;
      iconTheme = {
          package = pkgs.libsForQt5.breeze-icons;
          name = "breeze-dark";
      };
  };  

  

  home.file = {};

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
