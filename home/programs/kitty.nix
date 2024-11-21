{ pkgs, config, ... }:
{
  programs.kitty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.kitty;
    settings = {
      window_padding_width = 10;
      background_opacity = "0.8";
      background_blur = 5;
    };
  };
}
