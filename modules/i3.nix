{ }:
{
  system =
    { pkgs, ... }:
    {
      services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        windowManager.i3.enable = true;
      };

      services.displayManager = {
        defaultSession = "none+i3";
      };
    };
  home =
    { pkgs, ... }:
    let
      units = [
        {
          name = "base";
          config = "set $mod Mod4";
        }
        {
          name = "background";
          packages = [ pkgs.feh ];
          run =
            { ... }:
            {
              xdg.configFile."wallpaper.png".source = ../assets/wallpaper.png;
            };
          config = ''
            exec_always feh --bg-scale ~/.config/wallpaper.png
          '';
        }
        {
          name = "appearance";
          packages = [
            pkgs.picom
            pkgs.gruvbox-gtk-theme
          ];
          run =
            { ... }:
            {
              xdg.enable = true;
              xdg.configFile."gtk-3.0/settings.ini".text = ''
                [Settings]
                gtk-theme-name = Gruvbox-Dark
                gtk-font-name = CaskaydiaMono Nerd Font Mono 10
                gtk-application-prefer-dark-theme = true
              '';

              home.sessionVariables.GTK_THEME = "Gruvbox-Dark"; # for gtk4

              xdg.configFile."picom/picom.conf".text = ''
                #################################
                #           Fading              #
                #################################


                # Fade windows in/out when opening/closing and when opacity changes,
                #  unless no-fading-openclose is used.
                # fading = false
                fading = true;

                # Opacity change between steps while fading in. (0.01 - 1.0, defaults to 0.028)
                # fade-in-step = 0.028
                fade-in-step = 0.03;

                # Opacity change between steps while fading out. (0.01 - 1.0, defaults to 0.03)
                # fade-out-step = 0.03
                fade-out-step = 0.03;

                # The time between steps in fade step, in milliseconds. (> 0, defaults to 10)
                # fade-delta = 10

                # Specify a list of conditions of windows that should not be faded.
                # fade-exclude = []

                # Do not fade on window open/close.
                # no-fading-openclose = false

                # Do not fade destroyed ARGB windows with WM frame. Workaround of bugs in Openbox, Fluxbox, etc.
                # no-fading-destroyed-argb = false


                #################################
                #   Transparency / Opacity      #
                #################################


                # Opacity of inactive windows. (0.1 - 1.0, defaults to 1.0)
                # inactive-opacity = 1
                inactive-opacity = 0.95;

                # Opacity of window titlebars and borders. (0.1 - 1.0, disabled by default)
                # frame-opacity = 1.0
                frame-opacity = 0.5;

                # Let inactive opacity set by -i override the '_NET_WM_WINDOW_OPACITY' values of windows.
                # inactive-opacity-override = true
                inactive-opacity-override = false;

                # Default opacity for active windows. (0.0 - 1.0, defaults to 1.0)
                #active-opacity = 0.98

                # Dim inactive windows. (0.0 - 1.0, defaults to 0.0)
                # inactive-dim = 0.0

                # Specify a list of conditions of windows that should never be considered focused.
                # focus-exclude = []
                focus-exclude = [ "class_g = 'Cairo-clock'" ];

                # Use fixed inactive dim value, instead of adjusting according to window opacity.
                # inactive-dim-fixed = 1.0

                # Specify a list of opacity rules, in the format `PERCENT:PATTERN`,
                # like `50:name *= "Firefox"`. picom-trans is recommended over this.
                # Note we don't make any guarantee about possible conflicts with other
                # programs that set '_NET_WM_WINDOW_OPACITY' on frame or client windows.
                # example:
                #    opacity-rule = [ "80:class_g = 'URxvt'" ];
                #
                # opacity-rule = []


                #################################
                #           Corners             #
                #################################

                # Sets the radius of rounded window corners. When > 0, the compositor will
                # round the corners of windows. Does not interact well with
                # `transparent-clipping`.
                corner-radius = 8

                # Exclude conditions for rounded corners.
                rounded-corners-exclude = [
                  "window_type = 'dock'",
                  "window_type = 'desktop'"
                ];

                #################################
                #       General Settings        #
                #################################

                # Enable remote control via D-Bus. See the man page for more details.
                # dbus = true

                # Daemonize process. Fork to background after initialization. Causes issues with certain (badly-written) drivers.
                # daemon = false

                # Specify the backend to use: `xrender`, `glx`, `egl` or `xr_glx_hybrid`.
                # `xrender` is the default one.
                #
                # backend = "glx"
                backend = "xrender";

                # Use higher precision during rendering, and apply dither when presenting the
                # rendered screen. Reduces banding artifacts, but might cause performance
                # degradation. Only works with OpenGL.
                dithered-present = false;

                # Enable/disable VSync.
                # vsync = false
                vsync = true;

                # Try to detect WM windows (a non-override-redirect window with no
                # child that has 'WM_STATE') and mark them as active.
                #
                # mark-wmwin-focused = false
                mark-wmwin-focused = true;

                # Mark override-redirect windows that doesn't have a child window with 'WM_STATE' focused.
                # mark-ovredir-focused = false
                mark-ovredir-focused = true;

                # Try to detect windows with rounded corners and don't consider them
                # shaped windows. The accuracy is not very high, unfortunately.
                #
                # detect-rounded-corners = false
                detect-rounded-corners = true;

                # Detect '_NET_WM_WINDOW_OPACITY' on client windows, useful for window managers
                # not passing '_NET_WM_WINDOW_OPACITY' of client windows to frame windows.
                #
                # detect-client-opacity = false
                detect-client-opacity = true;

                # Use EWMH '_NET_ACTIVE_WINDOW' to determine currently focused window,
                # rather than listening to 'FocusIn'/'FocusOut' event. Might have more accuracy,
                # provided that the WM supports it.
                #
                # use-ewmh-active-win = false

                # Unredirect all windows if a full-screen opaque window is detected,
                # to maximize performance for full-screen windows. Known to cause flickering
                # when redirecting/unredirecting windows.
                #
                # unredir-if-possible = false

                # Delay before unredirecting the window, in milliseconds. Defaults to 0.
                # unredir-if-possible-delay = 0

                # Conditions of windows that shouldn't be considered full-screen for unredirecting screen.
                # unredir-if-possible-exclude = []

                # Use 'WM_TRANSIENT_FOR' to group windows, and consider windows
                # in the same group focused at the same time.
                #
                # detect-transient = false
                detect-transient = true;

                # Use 'WM_CLIENT_LEADER' to group windows, and consider windows in the same
                # group focused at the same time. This usually means windows from the same application
                # will be considered focused or unfocused at the same time.
                # 'WM_TRANSIENT_FOR' has higher priority if detect-transient is enabled, too.
                #
                # detect-client-leader = false

                # Resize damaged region by a specific number of pixels.
                # A positive value enlarges it while a negative one shrinks it.
                # If the value is positive, those additional pixels will not be actually painted
                # to screen, only used in blur calculation, and such. (Due to technical limitations,
                # with use-damage, those pixels will still be incorrectly painted to screen.)
                # Primarily used to fix the line corruption issues of blur,
                # in which case you should use the blur radius value here
                # (e.g. with a 3x3 kernel, you should use `--resize-damage 1`,
                # with a 5x5 one you use `--resize-damage 2`, and so on).
                # May or may not work with *--glx-no-stencil*. Shrinking doesn't function correctly.
                #
                # resize-damage = 1

                # Specify a list of conditions of windows that should be painted with inverted color.
                # Resource-hogging, and is not well tested.
                #
                # invert-color-include = []

                # GLX backend: Avoid using stencil buffer, useful if you don't have a stencil buffer.
                # Might cause incorrect opacity when rendering transparent content (but never
                # practically happened) and may not work with blur-background.
                # My tests show a 15% performance boost. Recommended.
                #
                # glx-no-stencil = false

                # GLX backend: Avoid rebinding pixmap on window damage.
                # Probably could improve performance on rapid window content changes,
                # but is known to break things on some drivers (LLVMpipe, xf86-video-intel, etc.).
                # Recommended if it works.
                #
                # glx-no-rebind-pixmap = false

                # Disable the use of damage information.
                # This cause the whole screen to be redrawn every time, instead of the part of the screen
                # has actually changed. Potentially degrades the performance, but might fix some artifacts.
                # The opposing option is use-damage
                #
                # no-use-damage = false
                use-damage = true;

                # Use X Sync fence to sync clients' draw calls, to make sure all draw
                # calls are finished before picom starts drawing. Needed on nvidia-drivers
                # with GLX backend for some users.
                #
                # xrender-sync-fence = false

                # GLX backend: Use specified GLSL fragment shader for rendering window
                # contents. Read the man page for a detailed explanation of the interface.
                #
                # window-shader-fg = "default"

                # Use rules to set per-window shaders. Syntax is SHADER_PATH:PATTERN, similar
                # to opacity-rule. SHADER_PATH can be "default". This overrides window-shader-fg.
                #
                # window-shader-fg-rule = [
                #   "my_shader.frag:window_type != 'dock'"
                # ]

                # Force all windows to be painted with blending. Useful if you
                # have a glx-fshader-win that could turn opaque pixels transparent.
                #
                # force-win-blend = false

                # Do not use EWMH to detect fullscreen windows.
                # Reverts to checking if a window is fullscreen based only on its size and coordinates.
                #
                # no-ewmh-fullscreen = false

                # Dimming bright windows so their brightness doesn't exceed this set value.
                # Brightness of a window is estimated by averaging all pixels in the window,
                # so this could comes with a performance hit.
                # Setting this to 1.0 disables this behaviour. Requires --use-damage to be disabled. (default: 1.0)
                #
                # max-brightness = 1.0

                # Make transparent windows clip other windows like non-transparent windows do,
                # instead of blending on top of them.
                #
                # transparent-clipping = false

                # Specify a list of conditions of windows that should never have transparent
                # clipping applied. Useful for screenshot tools, where you need to be able to
                # see through transparent parts of the window.
                #
                # transparent-clipping-exclude = []

                # Set the log level. Possible values are:
                #  "trace", "debug", "info", "warn", "error"
                # in increasing level of importance. Case doesn't matter.
                # If using the "TRACE" log level, it's better to log into a file
                # using *--log-file*, since it can generate a huge stream of logs.
                #
                # log-level = "debug"
                log-level = "warn";

                # Set the log file.
                # If *--log-file* is never specified, logs will be written to stderr.
                # Otherwise, logs will to written to the given file, though some of the early
                # logs might still be written to the stderr.
                # When setting this option from the config file, it is recommended to use an absolute path.
                #
                # log-file = "/path/to/your/log/file"

                # Show all X errors (for debugging)
                # show-all-xerrors = false

                # Write process ID to a file.
                # write-pid-path = "/path/to/your/log/file"

                # Window type settings
                #
                # 'WINDOW_TYPE' is one of the 15 window types defined in EWMH standard:
                #     "unknown", "desktop", "dock", "toolbar", "menu", "utility",
                #     "splash", "dialog", "normal", "dropdown_menu", "popup_menu",
                #     "tooltip", "notification", "combo", and "dnd".
                #
                # Following per window-type options are available: ::
                #
                #   fade, shadow:::
                #     Controls window-type-specific shadow and fade settings.
                #
                #   opacity:::
                #     Controls default opacity of the window type.
                #
                #   focus:::
                #     Controls whether the window of this type is to be always considered focused.
                #     (By default, all window types except "normal" and "dialog" has this on.)
                #
                #   full-shadow:::
                #     Controls whether shadow is drawn under the parts of the window that you
                #     normally won't be able to see. Useful when the window has parts of it
                #     transparent, and you want shadows in those areas.
                #
                #   clip-shadow-above:::
                #     Controls whether shadows that would have been drawn above the window should
                #     be clipped. Useful for dock windows that should have no shadow painted on top.
                #
                #   redir-ignore:::
                #     Controls whether this type of windows should cause screen to become
                #     redirected again after been unredirected. If you have unredir-if-possible
                #     set, and doesn't want certain window to cause unnecessary screen redirection,
                #     you can set this to `true`.
                #
                wintypes:
                {
                  tooltip = { fade = true; shadow = true; opacity = 0.75; focus = true; full-shadow = false; };
                  dock = { shadow = false; clip-shadow-above = true; }
                  dnd = { shadow = false; }
                  popup_menu = { opacity = 0.8; }
                  dropdown_menu = { opacity = 0.8; }
                };
              '';
            };
          config = ''
            set $color1 #171D28
            set $color2 #202734
            set $color3 #2D3441
            set $color4 #48556F
            set $color5 #A4B1CC

            gaps inner 8
            for_window [class=".*"] border none

            font pango:CaskaydiaMono Font Mono 10

            exec_always --no-startup-id picom --config ~/.config/picom/picom.conf
          '';
        }
        {
          name = "movements";
          config = ''
            floating_modifier $mod

            bindsym $mod+Shift+q kill

            bindsym $mod+h focus left
            bindsym $mod+j focus down
            bindsym $mod+k focus up
            bindsym $mod+l focus right

            bindsym $mod+Shift+h move left
            bindsym $mod+Shift+j move down
            bindsym $mod+Shift+k move up
            bindsym $mod+Shift+l move right

            bindsym $mod+f fullscreen toggle

            bindsym $mod+w layout tabbed
            bindsym $mod+e layout toggle split
          '';
        }
        {
          name = "applications";
          config = ''
            set $browser brave

            set $chatgpt_url "https://chatgpt.com/"
            set $pw_url "https://www.pw.live/study/batches/lakshya-jee-2-0-2025-073029/batch-overview?came_from=my-batches&activeSection=All%20Classes"
            set $notion_url "https://www.notion.so/"
            set $figma_url "https://www.figma.com/"
            set $telegram_url "https://web.telegram.org/k/"

            bindsym $mod+Return exec --no-startup-id kitty

            mode "application" {
              bindsym b exec --no-startup-id $browser --new-window; mode "default"
              
              bindsym Shift+c exec --no-startup-id $browser --new-window $chatgpt_url ; mode "default"
              bindsym c exec --no-startup-id $browser $chatgpt_url; mode "default"
              
              bindsym Shift+p exec --no-startup-id $browser --new-window $pw_url; mode "default"
              bindsym p exec --no-startup-id $browser $pw_url; mode "default"
              
              bindsym Shift+n exec --no-startup-id $browser --new-window $notion_url; mode "default"
              bindsym n exec --no-startup-id $browser $notion_url; mode "default"
              
              bindsym Shift+g exec --no-startup-id $browser --new-window $figma_url; mode "default"
              bindsym g exec --no-startup-id $browser $figma_url; mode "default"
              
              bindsym Shift+t exec --no-startup-id $browser --new-window $telegram_url; mode "default"
              bindsym t exec --no-startup-id $browser $telegram_url;  mode "default"
              
              bindsym e exec --no-startup-id blueman-manager;  mode "default"

              # return to normal
              bindsym Return mode "default"
              bindsym Escape mode "default"
            }

            bindsym $mod+a mode "application"
          '';
        }
        {
          name = "scratchpad";
          config = ''
            set $terminal_program kitty

            set $left_scratchpad_key o
            set $right_scratchpad_key p

            # auto launch two terminals for scratchpad
            exec --no-startup-id $terminal_program --class=left_scratchpad
            exec --no-startup-id $terminal_program --class=right_scratchpad

            # launch scratchpad terminal manually
            bindsym $mod+Shift+$left_scratchpad_key exec --no-startup-id $terminal_program --class=left_scratchpad
            bindsym $mod+Shift+$right_scratchpad_key exec --no-startup-id $terminal_program --class=right_scratchpad

            # toogle scratchpad terminal
            bindsym $mod+$left_scratchpad_key [class="left_scratchpad"] scratchpad show
            bindsym $mod+$right_scratchpad_key [class="right_scratchpad"] scratchpad show

            # move terminals to scratchpad and set their position
            for_window [class="left_scratchpad"] move to scratchpad, move position 8 px 544 px, resize set 948 px 528 px
            for_window [class="right_scratchpad"] move to scratchpad, move position 964 px 544 px, resize set 948 px 528 px
          '';
        }
        {
          name = "poweroff";
          config = ''
            mode "exit" {
                    bindsym $mod+Shift+e exec poweroff

                    # back to normal: Enter or Escape
                    bindsym Return mode "default"
                    bindsym Escape mode "default"
            }
            bindsym $mod+Shift+e mode "exit"
          '';
        }
        {
          name = "audio";
          packages = [ pkgs.wireplumber ];
          config = ''
            bindsym XF86AudioRaiseVolume exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
            bindsym XF86AudioLowerVolume exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
            bindsym XF86AudioMute exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

            bindsym XF86AudioMicMute exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
          '';
        }
        {
          name = "brightness";
          packages = [ pkgs.brightnessctl ];
          config = ''
            bindsym XF86MonBrightnessUp exec --no-startup-id brightnessctl set +10%
            bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl set 10%-
          '';
        }
        {
          name = "dex";
          packages = [ pkgs.dex ];
          config = ''
            exec --no-startup-id dex --autostart --environment i3
          '';
        }
        {
          name = "workspace";
          config = ''
            set $ws1 "[1]"
            set $ws2 "[2]"
            set $ws3 "[3]"
            set $ws4 "[4]"
            set $ws5 "[5]"

            exec --no-startup-id i3-msg workspace $ws1

            # switch to workspace
            bindsym $mod+1 workspace $ws1
            bindsym $mod+2 workspace $ws2
            bindsym $mod+3 workspace $ws3
            bindsym $mod+4 workspace $ws4
            bindsym $mod+5 workspace $ws5

            # move focused container to workspace
            bindsym $mod+Shift+1 move container to workspace $ws1
            bindsym $mod+Shift+2 move container to workspace $ws2
            bindsym $mod+Shift+3 move container to workspace $ws3
            bindsym $mod+Shift+4 move container to workspace $ws4
            bindsym $mod+Shift+5 move container to workspace $ws5
          '';
        }
        {
          name = "screenshot";
          packages = [
            pkgs.maim
            pkgs.xdotool
            pkgs.xclip
            pkgs.copyq
          ];
          run =
            { ... }:
            {
              home.file."Screenshots/.keep" = {
                text = "";
              };
            };
          config = ''
            #  Screenshots in file
            bindsym Print exec --no-startup-id maim --format=png "/home/$USER/Screenshots/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-all.png"
            bindsym $mod+Print exec --no-startup-id maim --format=png --window $(xdotool getactivewindow) "/home/$USER/Screenshots/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-current.png"
            bindsym Shift+Print exec --no-startup-id maim --format=png --select "/home/$USER/Screenshots/screenshot-$(date -u +'%Y%m%d-%H%M%SZ')-selected.png"

            # Screenshots in clipboards
            bindsym Ctrl+Print exec --no-startup-id maim --format=png | xclip -selection clipboard -t image/png
            bindsym Ctrl+$mod+Print exec --no-startup-id maim --format=png --window $(xdotool getactivewindow) | xclip -selection clipboard -t image/png
            bindsym Ctrl+Shift+Print exec --no-startup-id maim --format=png --select | xclip -selection clipboard -t image/png
          '';
        }
        {
          name = "resize";
          config = ''
            mode "resize" {
                    bindsym h resize shrink width 10 px or 10 ppt
                    bindsym j resize grow height 10 px or 10 ppt
                    bindsym k resize shrink height 10 px or 10 ppt
                    bindsym l  resize grow width 10 px or 10 ppt

                    bindsym Return mode "default"
                    bindsym Escape mode "default"
            }

            bindsym $mod+r mode "resize"
          '';
        }
        {
          name = "lockscreen";
          run =
            { ... }:
            {
              xdg.configFile."wallpaper.png".source = ../assets/wallpaper.png;
            };
          packages = [
            pkgs.betterlockscreen
            pkgs.xss-lock
          ];
          config = ''
            exec --no-startup-id xss-lock --transfer-sleep-lock -- betterlockscreen -u ~/.config/wallpaper.png -l dim --desc "Welcome Back Nandesh!"
          '';
        }
        {
          name = "dmenu";
          config = ''
            bindsym $mod+d exec --no-startup-id dmenu_run -nb '#282828' -nf '#ebdbb2' -sb '#689d6a' -sf '#ebdbb2' -fn "CascaydiaMono Nerd Font Mono"
          '';
        }
      ];
      activeUnits = units;
      packages = builtins.concatMap (unit: unit.packages) (
        builtins.filter (unit: builtins.hasAttr "packages" unit) activeUnits
      );
      imports = builtins.map (unit: unit.run) (
        builtins.filter (unit: builtins.hasAttr "run" unit) activeUnits
      );
      config = ''
        ${builtins.concatStringsSep "\n\n" (
          builtins.map (unit: unit.config) (
            builtins.filter (unit: builtins.hasAttr "config" unit) activeUnits
          )
        )}
      '';
    in
    {
      imports = imports;
      xsession = {
        enable = true;
        windowManager.i3 = {
          enable = true;
          package = pkgs.i3-gaps;
          config = {
            bars = [ ];
          };
          extraConfig = config;
        };
      };

      home.packages = packages;
    };
}
