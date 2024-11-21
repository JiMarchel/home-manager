{ pkgs, config, ... }:
 {
  wayland.windowManager.hyprland = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.hyprland;

    systemd.enable = true;
    xwayland.enable = true;

    settings = {
       exec-once = [
        "${(config.lib.nixGL.wrap pkgs.hyprpanel)}/bin/hyprpanel"
       ];

       monitor = [
        ",preferred,auto,1"
       ];

       general = {
         gaps_in = 5;
         gaps_out = 5;
         border_size = 3;
         layout = "dwindle";
         resize_on_border = true;
       };

       dwindle = {
         pseudotile = "yes";
         preserve_split = "yes";
         # no_gaps_when_only = "yes";
       };

      input = {
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          drag_lock = true;
        };
        sensitivity = 0;
        float_switch_override_focus = 2;
      };

      misc = {
        disable_splash_rendering = true;
        force_default_wallpaper = 1;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_use_r = true;
      };

      binds = {
        allow_workspace_cycles = true;
      };

      "$mainMod" = "SUPER";
      "$screenshot_dir" = "$HOME/Pictures/Screenshots";
      "$zen" = "$HOME/.local/share/AppImage/ZenBrowser.AppImage";
      bind =  [
        # Exit
        "CTRL ALT, Q, exit"

        # Top level bindings
        "$mainMod, Tab, cyclenext"
        "$mainMod, Return, exec, kitty"
        "$mainMod, W, exec, rofi -show drun"
        "$mainMod, E, exec, nautilus"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, B, exec, $zen"
        "$mainMod, F, exec, fullscreen"
        "$mainMod, G, togglegroup,"
        "$mainMod, P, pseudo,"
        "$mainMod, T, togglesplit,"
        "$mainMod, S, swapsplit,"

        # Second level bindings
        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, Space, togglefloating,"

        # Move focus with modifier + arrow keys
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        # Switch workspaces with modifier + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with modifier + Shift + [0-9]
        "$mainMod Shift, 1, movetoworkspace, 1"
        "$mainMod Shift, 2, movetoworkspace, 2"
        "$mainMod Shift, 3, movetoworkspace, 3"
        "$mainMod Shift, 4, movetoworkspace, 4"
        "$mainMod Shift, 5, movetoworkspace, 5"
        "$mainMod Shift, 6, movetoworkspace, 6"
        "$mainMod Shift, 7, movetoworkspace, 7"
        "$mainMod Shift, 8, movetoworkspace, 8"
        "$mainMod Shift, 9, movetoworkspace, 9"
        "$mainMod Shift, 0, movetoworkspace, 10"

        ", Print, exec, grim $screenshot_dir/$(date +'%Y-%m-%d_%H-%M-%S').png"
        "Shift, Print, exec, grim -g \"$(slurp)\" $screenshot_dir/$(date +'%Y-%m-%d_%H-%M-%S').png"
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      decoration = {
        # drop_shadow = "yes";
        # shadow_range = 8;
        # shadow_render_power = 2;
        # "col.shadow" = "rgba(00000044)";
        rounding = 8;
        dim_inactive = false;
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
          popups = true;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
    };

    extraConfig = ''
      # submap
      # will switch to a submap called resize
      bind = $mainMod, D, submap, resize

      # will start a submap called "resize"
      submap=resize

      # sets repeatable binds for resizing the active window
      binde=,right,resizeactive,40 0
      binde=,left,resizeactive,-40 0
      binde=,up,resizeactive,0 -40
      binde=,down,resizeactive,0 40

      # use reset to go back to the global submap
      bind=,escape,submap,reset 

      # will reset the submap, meaning end the current one and return to the global one
      submap=reset
    '';
  };
}
