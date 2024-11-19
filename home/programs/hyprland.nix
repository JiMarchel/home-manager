{ pkgs, config, inputs, ... }:
 {
  wayland.windowManager.hyprland = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.hyprland;

    systemd.enable = true;
    xwayland.enable = true;
    extraConfig = ''
            env = WLR_NO_HARDWARE_CURSORS,1

            #     Monitors
            # See https://wiki.hyprland.org/Configuring/Monitors/

            #Main config
            # laptop monitor:
            #monitor=eDP-1,1920x1080@60,860x1440,1 # Setup 1, Center below
            monitor=eDP-1,1920x1080@60,0x1440,1 # Setup 2, Left below

            # Every other undefined monitor. This is configured to be above the laptop.
            #monitor=,highres,0x0,1 # Setup 1, Center above
            monitor=,highres,1920x0,1 # Setup 2, Right below
            #monitor=,3440x1440@100,0x0,1

            # ##########################################################
            #
            #     KeyBinds
            #
            # #########################################################

            # See https://wiki.hyprland.org/Configuring/Keywords/ for more
            $mainMod = SUPER 

            bind = $mainMod, F1, togglespecialworkspace, special-chat
            bind = $mainMod SHIFT, F1, movetoworkspace, special:special-chat
            bind = $mainMod, F2, togglespecialworkspace, special-term
            bind = $mainMod SHIFT, F2, movetoworkspace, special:special-term
            bind = $mainMod, 49, togglespecialworkspace # Default unnamed workspace # 49 = |
            bind = $mainMod, F3, togglespecialworkspace # Default unnamed workspace
            bind = $mainMod SHIFT, F3, movetoworkspace, special
            bind = $mainMod, F4, exec, clipman pick -t wofi # Clipboard History
            workspace = special:special-chat,gapsin:1,gapsout:0,bordersize:1
            workspace = special:special-term,gapsin:1,gapsout:0,bordersize:1
            workspace = special,gapsin:1,gapsout:0,bordersize:0,on-created-empty:WARP_ENABLE_WAYLAND=1 WGPU_BACKEND=vulkan warp-terminal
            animation=specialWorkspace,1,8,default,slidefadevert -80%
			
			# I use these paste files to put frequently used commands. Usefull when maintaining servers via SSH.
            bind = , F5, exec, wl-copy < ~/paste1.txt && ydotool key 42:1 29:1 47:1 47:0 29:0 42:0 # Shift(42) CTRL(29) v(47)  # Paste content of file. Couldnt use only ydotool here, because of keyboard layout bug.
            bind = , F6, exec, wl-copy < ~/paste2.txt && ydotool key 42:1 29:1 47:1 47:0 29:0 42:0 # Shift(42) CTRL(29) v(47)  # Paste content of file. Couldnt use only ydotool here, because of keyboard layout bug.
            bind = , F7, exec, wl-copy < ~/paste3.txt && ydotool key 42:1 29:1 47:1 47:0 29:0 42:0 # Shift(42) CTRL(29) v(47)  # Paste content of file. Couldnt use only ydotool here, because of keyboard layout bug.
            
            # ################################
            # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
             # can check the keyname with: xev

            bind = $mainMod, B, exec, zen 
            bind = $mainMod, T, exec, wezterm 
            bind = $mainMod, L, exec, swaylock --clock --indicator --screenshots --effect-scale 0.4 --effect-vignette 0.2:0.5 --effect-blur 4x2 --datestr "%a %e.%m.%Y" --timestr "%k:%M" 
            bind = $mainMod, Print , exec , grim  
            bind = $mainMod, G, togglefloating  
            bind = $mainMod, F, fullscreen, 1  
            bind = $mainMod SHIFT, F, fullscreen  
            bind = $mainMod, Return, exec, footclient
            bind = $mainMod, Q, killactive, 
            bind = $mainMod SHIFT, E, exec, nwgbar  
            bind = $mainMod, N, exec, thunar 
            bind = $mainMod SHIFT, 65, togglefloating, 
            bind = $mainMod, D, exec, wofi -i -G --show drun --allow-images 
            bind = $mainMod SHIFT, D, exec, nwg-drawer 
            bind = $mainMod, P, pseudo, # dwindle 
            bind = $mainMod, J, togglesplit, # dwindle 
            # #################################

            # Move focus with mainMod + arrow keys
            bind = $mainMod, left, workspace, r-1
            bind = $mainMod, right, workspace, r+1
            bind = $mainMod SHIFT, left, movetoworkspace, r-1
            bind = $mainMod SHIFT, right, movetoworkspace, r+1
            bind = $mainMod,up, focusmonitor, u
            bind = $mainMod,down, focusmonitor, d
            bind = $mainMod SHIFT,up, movecurrentworkspacetomonitor, u
            bind = $mainMod SHIFT,down, movecurrentworkspacetomonitor, d

            # Switch workspaces with mainMod + [0-9]
            bind = $mainMod, 1, workspace, 1
            bind = $mainMod, 2, workspace, 2
            bind = $mainMod, 3, workspace, 3
            bind = $mainMod, 4, workspace, 4
            bind = $mainMod, 5, workspace, 5
            bind = $mainMod, 6, workspace, 6
            bind = $mainMod, 7, workspace, 7
            bind = $mainMod, 8, workspace, 8
            bind = $mainMod, 9, workspace, 9
            bind = $mainMod, 0, workspace, 10

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            bind = $mainMod SHIFT, 1, movetoworkspace, 1
            bind = $mainMod SHIFT, 2, movetoworkspace, 2
            bind = $mainMod SHIFT, 3, movetoworkspace, 3
            bind = $mainMod SHIFT, 4, movetoworkspace, 4
            bind = $mainMod SHIFT, 5, movetoworkspace, 5
            bind = $mainMod SHIFT, 6, movetoworkspace, 6
            bind = $mainMod SHIFT, 7, movetoworkspace, 7
            bind = $mainMod SHIFT, 8, movetoworkspace, 8
            bind = $mainMod SHIFT, 9, movetoworkspace, 9
            bind = $mainMod SHIFT, 0, movetoworkspace, 10

            # Scroll through existing workspaces with mainMod + scroll
            bind = $mainMod, mouse_down, workspace, m+1
            bind = $mainMod, mouse_up, workspace, m-1

            # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod, mouse:273, resizewindow

            bind = ,232,exec,brightnessctl -c backlight set 5%-
            bind = ,233,exec,brightnessctl -c backlight set +5%

            # set volume (laptops only and may or may not work on PCs)
            bind = ,122, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
            bind = ,123, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
            bind = ,121, exec, pactl set-sink-volume @DEFAULT_SINK@ 0%

            bind = $mainMod, S, exec, grimblast --notify copysave area
            #bind = , Print, exec, grimblast --notify --cursor copysave output
            #bind = ALT, Print, exec, grimblast --notify --cursor copysave screen

            # ######################
            # for resizing window
            # will switch to a submap called resize
            bind=$mainMod,R,submap,resize 
            # will start a submap called "resize"
            submap=resize
            # sets repeatable binds for resizing the active window
            binde=,right,resizeactive,10 0
            binde=,left,resizeactive,-10 0
            binde=,up,resizeactive,0 -10
            binde=,down,resizeactive,0 10
            # use reset to go back to the global submap
            bind=,escape,submap,reset 
            # will reset the submap, meaning end the current one and return to the global one
            submap=reset
            # ######################

            # to move window
            #bind = $mainMod SHIFT,up, movewindow, u
            #bind = $mainMod SHIFT,down, movewindow, d
            #bind = $mainMod SHIFT,left, movewindow, l
            #bind = $mainMod SHIFT,right, movewindow, r


            # ##########################################################
            #
            #     Settings
            #
            # #########################################################

            # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
            input {
                kb_layout = no
                kb_variant =
                kb_model =
                kb_options =
                kb_rules =

                numlock_by_default = true

                follow_mouse = 1

                touchpad {
                    natural_scroll = yes
                    clickfinger_behavior  = true 
                }

                sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
            }

            general {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more

                gaps_in = 5
                gaps_out = 10
                border_size = 2
                col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
                col.inactive_border = rgba(595959aa)

                layout = dwindle
            }

            decoration {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more

                active_opacity = 0.8
                inactive_opacity = 0.7


                rounding = 10
                blur {
                    enabled = yes
                    size = 5
                    passes = 3
                    new_optimizations = on
                }
                drop_shadow = yes
                shadow_range = 4
                shadow_render_power = 3
                col.shadow = rgba(1a1a1aee)
            }

            animations {
                enabled = yes

                # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

                bezier = myBezier, 0.05, 0.9, 0.1, 1.05

                animation = windows, 1, 7, myBezier
                animation = windowsOut, 1, 7, default, popin 80%
                animation = border, 1, 10, default
                animation = fade, 1, 7, default
                animation = workspaces, 1, 6, default
            }

            dwindle {
                # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
                pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = yes # you probably want this
                special_scale_factor = 1.0
            }

            master {
                # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
                new_is_master = true
                special_scale_factor = 1.0
            }

            gestures {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more
                workspace_swipe = on
            }
            misc {
                disable_hyprland_logo = true
            }
            # Example per-device config
            # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more







            # ##########################################################
            #
            #     Window Rules
            #
            # #########################################################
            # Example windowrule v1
            # windowrule = float, ^(kitty)$
            # Example windowrule v2
            # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
            # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


            windowrule = opacity 0.85 override 0.85 override,^(thunar)$ 
            windowrulev2 = float,class:^(thunar)$

            windowrule = opacity 0.85 override 0.85 override,^(catfish)$ 
            
            windowrulev2 = opacity 1.0 override 1.0 override,class:^(firefox)$
            windowrulev2 = opacity 1.0 override 1.0 override,class:^(vivaldi-stable)$
            windowrulev2 = opacity 1.0 1.0, floating:1,class:^(vivaldi-stable)$


            windowrulev2 = opacity 1.0 override 1.0 override,class:^(Microsoft-edge)$
            windowrulev2 = tile,class:^(Microsoft-edge)$
            windowrulev2 = opacity 1.0 override 1.0 override,class:^(TradingView)$

            
            windowrulev2 = opacity 1.0 override 1.0 override,class:^(evince)$ # Document viewer

            windowrulev2 = opacity 1.0 override 1.0 override,class:^(warzone2100)$ # Game 
            windowrulev2 = fakefullscreen ,class:^(warzone2100)$ # Game 
            

            #	windowrulev2 = nomaxsize,class:^(terminal.exe)$

            #	windowrulev2 = monitor eDP-1,class:^(terminal.exe)$

            # warp-terminal
            windowrulev2 = tile,class:^(dev.warp.Warp)$

            windowrulev2 = opacity 1.0 override 1.0 override,title:^(.*Picture in picture.*)$

            #windowrulev2 = opacity 1 override 1 override, tile ,title:^(.*Spotify.*)$
            windowrule = tile,title:^(spotify)$


            #window rules with evaluation
            #windowrulev2 = opacity 0.85 0.85,floating:1
            windowrulev2 = opacity 1 1,floating:1


            # other blurings
            blurls = wofi
            blurls = gtk-layer-shell # for nwg-drawer
            #blurls = waybar


            # ##########################################################
            #
            #     Startup
            #
            # #########################################################



            # Execute your favorite apps at launch
            # exec-once = waybar & hyprpaper & vivaldi

            #status bar
            exec-once = waybar

            #Background
            #exec-once = wpaperd
            #exec-once = swaybg -m fill -i ~/.nix-profile/share/hyprland/wall_anime_8K.png
            exec-once = swaybg -m fill -i ~/.nix-profile/share/hyprland/wall2.png
            
            #idle. Lock after 10 min. Turn off monitor after 30 min
            #	exec-once = swayidle -w timeout 600 'swaylock --clock --indicator --screenshots --effect-scale 0.4 --effect-vignette 0.2:0.5 --effect-blur 4x2 --datestr "%a %e.%m.%Y" --timestr "%k:%M"' timeout 1800 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
            exec-once = swayidle -w timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'


            #executions which i am not certainly sure that will work for every one yeah they are also not that much important but if work then setup will become great!!
            
            #Sway Notification Center
            exec-once = swaync
            
            exec-once = xrandr --output eDP-1 --primary # Workaround for issues with wine windows.
            #exec-once = /usr/lib/polkit-kde-authentication-agent-1
            exec-once =  ~/.nix-profile/libexec/polkit-kde-authentication-agent-1 
            
            # This will make sure that xdg-desktop-portal-hyprland can get the required variables on startup.
            exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
            #exec-once = /usr/lib/xdg-desktop-portal-hyprland
            exec-once = ~/.nix-profile/libexec/xdg-desktop-portal-hyprland
            #exec-once = ~/.nix-profile/libexec/xdg-desktop-portal

            exec-once = nm-applet --indicator # Network manager applet in waybar
            exec-once = wl-paste -t text --watch clipman store --no-persist  # Copy history, accessible via "SUPER + F4"
            exec-once = ydotoold # background service for the ydotool
			
      '';
  };
}
