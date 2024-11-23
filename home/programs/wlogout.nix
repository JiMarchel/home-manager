{
  programs.wlogout = {
    enable = true;
    layout = [
      {
          label = "lock";
          action = "swaylock";
          text = "Lock";
          keybind = "l";
      }
      {
          label = "logout";
          action = "hyprctl dispatch exit 0";
          text = "Logout";
          keybind = "e";
      }
      {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
      }
      {
          label = "suspend";
          action = "swaylock -f && systemctl suspend";
          text = "Suspend";
          keybind = "u";
      }
      {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
      }
      {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
      }
    ];
  };
}

