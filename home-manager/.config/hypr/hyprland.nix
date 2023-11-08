{ config, pkgs, ... }: {
  wayland.windowManager.hyprland.extraConfig = ''

    # █▀▀ ▀▄▀ █▀▀ █▀▀
    # ██▄ █░█ ██▄ █▄▄
    exec-once = wl-clipboard-history -t
    exec-once = ~/.config/hypr/xdg-portal-hyprland
    exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
    exec = swaybg -m fill -i ~/.local/share/wallpapers/wallpaper.jpg
    exec-once = waybar
    exec-once= bash ~/.config/waybar/scripts/mediaplayer.sh

    exec-once=hyprctl setcursor Bibata-Modern-Ice 16

    # █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
    # █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄
    monitor=,preferred,auto,1

    # █ █▄░█ █▀█ █░█ ▀█▀
    # █ █░▀█ █▀▀ █▄█ ░█░
    input {
    follow_mouse = 1
    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

    # █▀▀ █▀▀ █▄░█ █▀▀ █▀█ ▄▀█ █░░
    # █▄█ ██▄ █░▀█ ██▄ █▀▄ █▀█ █▄▄
    general {
    gaps_in=5
    gaps_out=10
    border_size=0
    no_border_on_floating = true
    layout = dwindle
    }

    # █▀▄▀█ █ █▀ █▀▀
    # █░▀░█ █ ▄█ █▄▄
    misc {
    disable_hyprland_logo = true
    disable_splash_rendering = true
    mouse_move_enables_dpms = true
    enable_swallow = true
    swallow_regex = ^(alacritty)$
    }

    # █▀▄ █▀▀ █▀▀ █▀█ █▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
    # █▄▀ ██▄ █▄▄ █▄█ █▀▄ █▀█ ░█░ █ █▄█ █░▀█

    decoration {
    # █▀█ █▀█ █░█ █▄░█ █▀▄   █▀▀ █▀█ █▀█ █▄░█ █▀▀ █▀█
    # █▀▄ █▄█ █▄█ █░▀█ █▄▀   █▄▄ █▄█ █▀▄ █░▀█ ██▄ █▀▄
    rounding = 10
    multisample_edges = true

    # █▀█ █▀█ ▄▀█ █▀▀ █ ▀█▀ █▄█
    # █▄█ █▀▀ █▀█ █▄▄ █ ░█░ ░█░
    active_opacity = 1.0
    inactive_opacity = 0.9

    # █▄▄ █░░ █░█ █▀█
    # █▄█ █▄▄ █▄█ █▀▄
    blur {
    enabled = true
    size = 3
    passes = 3
    new_optimizations = true
    ignore_opacity = true
    }


    # █▀ █░█ ▄▀█ █▀▄ █▀█ █░█░█
    # ▄█ █▀█ █▀█ █▄▀ █▄█ ▀▄▀▄▀
    drop_shadow = true
    shadow_ignore_window = true
    shadow_offset = 2 2
    shadow_range = 4
    shadow_render_power = 2
    col.shadow = 0x66000000

    blurls = gtk-layer-shell
    # blurls = waybar
    blurls = lockscreen
    }

    # ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
    # █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█
    animations {
    enabled = true
    # █▄▄ █▀▀ ▀█ █ █▀▀ █▀█   █▀▀ █░█ █▀█ █░█ █▀▀
    # █▄█ ██▄ █▄ █ ██▄ █▀▄   █▄▄ █▄█ █▀▄ ▀▄▀ ██▄
    bezier = overshot, 0.05, 0.9, 0.1, 1.05
    bezier = smoothOut, 0.36, 0, 0.66, -0.56
    bezier = smoothIn, 0.25, 1, 0.5, 1

    animation = windows, 1, 5, overshot, slide
    animation = windowsOut, 1, 4, smoothOut, slide
    animation = windowsMove, 1, 4, default
    animation = border, 1, 10, default
    animation = fade, 1, 10, smoothIn
    animation = fadeDim, 1, 10, smoothIn
    animation = workspaces, 1, 6, default

    }

    # █░░ ▄▀█ █▄█ █▀█ █░█ ▀█▀ █▀
    # █▄▄ █▀█ ░█░ █▄█ █▄█ ░█░ ▄█

    dwindle {
    no_gaps_when_only = false
    pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true # you probably want this
    }

    # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
    # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█
    windowrule = float, file_progress
    windowrule = float, confirm
    windowrule = float, dialog
    windowrule = float, download
    windowrule = float, notification
    windowrule = float, error
    windowrule = float, splash
    windowrule = float, confirmreset
    windowrule = float, title:Open File
    windowrule = float, title:branchdialog
    windowrule = float, Lxappearance
    windowrule = float, thunar
    windowrule = animation none,fuzzel
    windowrule = float,viewnior
    windowrule = float, blueberry
    windowrule = float, pavucontrol-qt
    windowrule = float, pavucontrol
    windowrule = float, file-roller
    windowrule = fullscreen, wlogout
    windowrule = float, title:wlogout
    windowrule = fullscreen, title:wlogout
    windowrule = idleinhibit fullscreen, firefox
    windowrule = float, title:^(Media viewer)$
    windowrule = float, title:^(Volume Control)$
    windowrule = float, title:^(Picture-in-Picture)$
    windowrule = size 800 600, title:^(Volume Control)$
    windowrule = move 75 44%, title:^(Volume Control)$

    # █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄
    # █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀

    bind = SUPER SHIFT, Return, exec, google-chrome-stable

    # █▀▄▀█ █░█ █░░ ▀█▀ █ █▀▄▀█ █▀▀ █▀▄ █ ▄▀█
    # █░▀░█ █▄█ █▄▄ ░█░ █ █░▀░█ ██▄ █▄▀ █ █▀█
    binde=, XF86AudioRaiseVolume, exec, amixer set Master 3%+
    binde=, XF86AudioLowerVolume, exec, amixer set Master 3%-
    binde=, XF86AudioMute, exec, amixer set Master toggle

    bind=,XF86MonBrightnessDown,exec,brightnessctl set 5%-
    bind=,XF86MonBrightnessUp,exec,brightnessctl set +5%


    # █▀ █▀▀ █▀█ █▀▀ █▀▀ █▄░█ █▀ █░█ █▀█ ▀█▀
    # ▄█ █▄▄ █▀▄ ██▄ ██▄ █░▀█ ▄█ █▀█ █▄█ ░█░
    bind = SUPER SHIFT, P, exec, grim -g "$(slurp)" - | swappy -f -
    bind = SUPER SHIFT, F, exec, grim - | swappy -f -

    # █▀▄▀█ █ █▀ █▀▀
    # █░▀░█ █ ▄█ █▄▄
    bind = SUPER SHIFT, X, exec, hyprpicker -a -n
    bind = CTRL ALT, L, exec, swaylock
    bind = SUPER, Return, exec, alacritty
    bind = SUPER, S, exec, pavucontrol
    bind = SUPER, B, exec, blueberry
    bind = SUPER, E, exec, thunar
    bind = SUPER, Space, exec, fuzzel
    #bind = SUPER, period, exec, killall rofi || rofi -show emoji -emoji-format "{emoji}" -modi emoji -theme ~/.config/rofi/global/emoji
    #bind = SUPER, escape, exec, wlogout --protocol layer-shell -b 5 -T 400 -B 400

    # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
    # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █░▀░█ █▀█ █░▀█ █▀█ █▄█ █░▀░█ ██▄ █░▀█ ░█░
    bind = SUPER, Q, killactive,
    bind = SUPER SHIFT, E, exit,
    bind = SUPER, A, fullscreen,
    bind = SUPER, F, togglefloating,
    bind = SUPER, P, pseudo, # dwindle
    bind = SUPER, X, togglesplit, # dwindle

    # bind=,Print,exec,grim $(xdg-user-dir PICTURES)/Screenshots/$(date +'%Y%m%d%H%M%S_1.png') && notify-send 'Screenshot Saved'
    # bind=SUPER,Print,exec,grim - | wl-copy && notify-send 'Screenshot Copied to Clipboard'
    # bind=SUPERSHIFT,Print,exec,grim - | swappy -f -
    # bind=SUPERSHIFT,S,exec,slurp | grim -g - $(xdg-user-dir PICTURES)/Screenshots/$(date +'%Y%m%d%H%M%S_1.png') && notify-send 'Screenshot Saved'

    # █▀▀ █▀█ █▀▀ █░█ █▀
    # █▀░ █▄█ █▄▄ █▄█ ▄█
    bind = SUPER, left, movefocus, l
    bind = SUPER, right, movefocus, r
    bind = SUPER, up, movefocus, u
    bind = SUPER, down, movefocus, d

    # █▀▄▀█ █▀█ █░█ █▀▀
    # █░▀░█ █▄█ ▀▄▀ ██▄
    bind = SUPER SHIFT, left, movewindow, l
    bind = SUPER SHIFT, right, movewindow, r
    bind = SUPER SHIFT, up, movewindow, u
    bind = SUPER SHIFT, down, movewindow, d

    # █▀█ █▀▀ █▀ █ ▀█ █▀▀
    # █▀▄ ██▄ ▄█ █ █▄ ██▄
    bind = SUPER CTRL, left, resizeactive, -20 0
    bind = SUPER CTRL, right, resizeactive, 20 0
    bind = SUPER CTRL, up, resizeactive, 0 -20
    bind = SUPER CTRL, down, resizeactive, 0 20

    # ▀█▀ ▄▀█ █▄▄ █▄▄ █▀▀ █▀▄
    # ░█░ █▀█ █▄█ █▄█ ██▄ █▄▀
    bind= SUPER, g, togglegroup,
    bind= SUPER, tab, changegroupactive,

    # █▀ █▀█ █▀▀ █▀▀ █ ▄▀█ █░░
    # ▄█ █▀▀ ██▄ █▄▄ █ █▀█ █▄▄
    bind = SUPER, grave, togglespecialworkspace,
    bind = SUPERSHIFT, grave, movetoworkspace, special

    # █▀ █░█░█ █ ▀█▀ █▀▀ █░█
    # ▄█ ▀▄▀▄▀ █ ░█░ █▄▄ █▀█
    bind = SUPER, 1, workspace, 1
    bind = SUPER, 2, workspace, 2
    bind = SUPER, 3, workspace, 3
    bind = SUPER, 4, workspace, 4
    bind = SUPER, 5, workspace, 5
    bind = SUPER, 6, workspace, 6
    bind = SUPER, 7, workspace, 7
    bind = SUPER, 8, workspace, 8
    bind = SUPER, 9, workspace, 9
    bind = SUPER, 0, workspace, 10
    bind = SUPER ALT, up, workspace, e+1
    bind = SUPER ALT, down, workspace, e-1

    # █▀▄▀█ █▀█ █░█ █▀▀
    # █░▀░█ █▄█ ▀▄▀ ██▄
    bind = SUPER SHIFT, 1, movetoworkspace, 1
    bind = SUPER SHIFT, 2, movetoworkspace, 2
    bind = SUPER SHIFT, 3, movetoworkspace, 3
    bind = SUPER SHIFT, 4, movetoworkspace, 4
    bind = SUPER SHIFT, 5, movetoworkspace, 5
    bind = SUPER SHIFT, 6, movetoworkspace, 6
    bind = SUPER SHIFT, 7, movetoworkspace, 7
    bind = SUPER SHIFT, 8, movetoworkspace, 8
    bind = SUPER SHIFT, 9, movetoworkspace, 9
    bind = SUPER SHIFT, 0, movetoworkspace, 10

    # █▀▄▀█ █▀█ █░█ █▀ █▀▀   █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀
    # █░▀░█ █▄█ █▄█ ▄█ ██▄   █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█
    bindm = SUPER, mouse:273, movewindow
    bindm = SUPER, mouse:272, resizewindow
    bind = SUPER, mouse_down, workspace, e+1
    bind = SUPER, mouse_up, workspace, e-1
  '';
}
