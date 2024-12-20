{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;
    image = ../../wallpaper/53.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    targets = {
      vscode.enable = false;
      kitty.enable = false;
      nixvim.enable = false;
    };

    fonts = {
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 13;
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter Variable";
      };
      monospace = {
        package = (
          pkgs.nerdfonts.override {
            fonts = [
              "JetBrainsMono"
              "RobotoMono"
            ];
          }
        );
        name = "JetBrainsMono NF";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 32;
    };
    opacity.terminal = 0.9;
  };
}
