{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "ls -lAh --color=auto";
      ff = "fastfetch --kitty-direct /home/marchel/home-manager/wallpaper/ff-1.png";
    };
  };
}
