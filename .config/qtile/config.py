import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List
from libqtile.widget import base

mod = "mod4"
myTerm = "st"

keys = [
         Key([mod], "Return",
             lazy.spawn(myTerm),
             desc='Launches My Terminal'
             ),
         Key([mod], "x",
             lazy.spawn("bash ~/dmscripts/power"),
             ),
         Key([mod, "shift"], "d",
             lazy.spawn("dmenu_run"),
             desc='Run Launcher'
             ),
         Key([mod, "shift"], "space",
             lazy.next_layout(),
             desc='Toggle through layouts'
             ),
         Key([mod, "shift"], "x",
             lazy.window.kill(),
             desc='Kill active window'
             ),
         Key([mod, "shift"], "r",
             lazy.restart(),
             desc='Restart Qtile'
             ),
         Key([mod, "shift"], "q",
             lazy.shutdown(),
             desc='Shutdown Qtile'
             ),
         Key(["control", "shift"], "e",
             lazy.spawn("lxtask"),
             desc='System Monitor'
             ),
         Key([mod], "w",
             lazy.spawn("firefox"),
             desc='Brave'
             ),
         Key([mod, "shift"], "m",
             lazy.spawn("thunderbird"),
             desc='mailclient'
             ),
         Key([mod], "d",
             lazy.spawn("deadbeef"),
             desc='deadbeef'
             ),
         Key([mod, "shift"], "Return",
             lazy.spawn("pcmanfm"),
             desc='File Manager'
             ),
         Key([mod], "v",
             lazy.spawn("pavucontrol"),
             desc='Volume Equalizer'
             ),
         Key([mod], "b",
             lazy.spawn("firefox"),
             desc='brave'
             ),
         Key([mod], "g",
             lazy.spawn("spotify"),
             desc='spotify'
             ),
          Key([mod, "shift"], "h",
             lazy.layout.move_left(),
             desc='Move up a section in treetab'
             ),
         Key([mod, "shift"], "l",
             lazy.layout.move_right(),
             desc='Move down a section in treetab'
             ),


            Key([], "XF86AudioLowerVolume", lazy.spawn(
                "pactl set-sink-volume @DEFAULT_SINK@ -5%")),
            Key([], "XF86AudioRaiseVolume", lazy.spawn(
                "pactl set-sink-volume @DEFAULT_SINK@ +5%")),
            Key([], "XF86AudioMute", lazy.spawn(
                "pactl set-sink-mute @DEFAULT_SINK@ toggle")),

            Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc +5%")),
            Key([], "XF86MonBrightnessDown",
                lazy.spawn("xbacklight -dec 5%")),

            Key([], "Print", lazy.spawn("scrot -s -q 100 -e 'mv $f ~/Screenshots/'")),

         Key([mod], "Down",
             lazy.layout.down(),
             desc='Move focus down in current stack pane'
             ),
         Key([mod], "Up",
             lazy.layout.up(),
             desc='Move focus up in current stack pane'
             ),
         Key([mod, "shift"], "Down",
             lazy.layout.shuffle_down(),
             lazy.layout.section_down(),
             desc='Move windows down in current stack'
             ),
         Key([mod, "shift"], "Up",
             lazy.layout.shuffle_up(),
             lazy.layout.section_up(),
             desc='Move windows up in current stack'
             ),
         Key([mod], "Left",
             lazy.layout.shrink(),
             lazy.layout.decrease_nmaster(),
             desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
             ),
         Key([mod], "Right",
             lazy.layout.grow(),
             lazy.layout.increase_nmaster(),
             desc='Expand window (MonadTall), increase number in master pane (Tile)'
             ),
         Key([mod], "n",
             lazy.layout.normalize(),
             desc='normalize window size ratios'
             ),
         Key([mod], "m",
             lazy.layout.maximize(),
             desc='toggle window between minimum and maximum sizes'
             ),
         Key([mod, "shift"], "f",
             lazy.window.toggle_floating(),
             desc='toggle floating'
             ),
         Key([mod], "m",
             lazy.window.toggle_fullscreen(),
             desc='toggle fullscreen'
             ),
         Key([mod, "shift"], "Tab",
             lazy.layout.rotate(),
             lazy.layout.flip(),
             desc='Switch which side main pane occupies (XmonadTall)'
             ),
          Key([mod], "space",
             lazy.next_layout(),
             desc='Switch window focus to other pane(s) of stack'
             ),
         Key([mod, "shift"], "space",
             lazy.layout.toggle_split(),
             desc='Toggle between split and unsplit sides of stack'
             )
         ]

group_names = [(" ", {'layout': 'monadtall'}),
               (" ", {'layout': 'monadtall'}),
               (" ", {'layout': 'monadtall'}),
               (" ", {'layout': 'monadtall'}),
               (" ", {'layout': 'monadtall'}),
               (" ", {'layout': 'monadtall'}),
               (" ", {'layout': 'monadtall'}),
               (" ", {'layout': 'monadtall'}),
               ("", {'layout': 'monadtall'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group

layout_theme = {"border_width": 1,
                "margin": 4,
                "border_focus": "#091236",
                "border_normal": "#8d93a8"
                }

layouts = [
    layout.MonadTall(**layout_theme),
    #layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.Columns(**layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Zoomy(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2),
    layout.RatioTile(**layout_theme),
    layout.Floating(**layout_theme)
]

colors = [["#0e1014", "#0e1014"], # panel background
          ["#3d3f4b", "#434758"], # background for current screen tab
          ["#ffffff", "#ffffff"], # font color for group names
          ["#ff5555", "#ff5555"], # border line color for current tab
          ["#192620", "#102620"], # border line color for 'other tabs' and color for 'odd widgets'
          ["#060a08", "#060a08"], # color for the 'even widgets'
          ["#d8dfed", "#d8dfed"], # window name
          ["#d5dbda", "#d5dbda"]] # backbround for inactive screens

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

screens = [
    Screen(
            top=bar.Bar(
            [
                widget.TextBox(
                        text = '  ',
                        fontsize = 17,
                        font = "Mononoki Nerd Font",
                        foreground = colors[2],
                        background = colors[0],
                        ),    
                widget.GroupBox(
                    font = "Mononoki Nerd Font",
                       fontsize = 17,
                       margin_y = 3,
                       margin_x = 2,
                       padding_y = 2,
                       padding_x = 3,
                       borderwidth = 3,
                       active = colors[2],
                       inactive = colors[7],
                       rounded = False,
                       highlight_color = colors[1],
                       highlight_method = "line",
                       this_current_screen_border = colors[6],
                       this_screen_border = colors [4],
                       other_current_screen_border = colors[6],
                       other_screen_border = colors[4],
                       foreground = colors[2],
                       background = colors[0]
                        ),
                widget.TextBox(
                       text = '|',
                       padding = 5,
                       foreground = colors[2],
                       background = colors[0],
                       fontsize = 16
                       ),
                widget.CurrentLayout(
                        font = "Roboto",
                        fontsize = 14,
                        ),
                widget.TextBox(
                       text = '|',
                       padding = 5,
                       foreground = colors[2],
                       background = colors[0],
                       fontsize = 16
                       ),
                 widget.WindowName(
                        font = "Roboto",
                        fontsize = 12,
                        ),
                widget.TextBox(
                       text = '',
                       font = 'Mononoki Nerd Font',
                       padding = 5,
                       foreground = colors[2],
                       background = colors[0],
                       fontsize = 16
                       ),
                widget.Battery(
                        battery = 0,
                        charge_char = 'Char',
                        discharge_char = 'Dis',
                        empty_char = 'x',
                        font = 'Roboto',
                        fontsize = 14,
                        format = '{char} {percent:2.0%} {hour:d}:{min:02d}  ',
                        full_charge = '=',
                        notify_below = None,
                        update_interval = 15,
                        ),
                widget.TextBox(
                       text = '',
                       padding = 5,
                       foreground = colors[2],
                       background = colors[0],
                       font = 'Mononoki Nerd Font',
                       fontsize = 16
                       ),
                widget.CPU(
                        fmt = '{}',
                        font = 'Roboto',
                        fontsize = 14,
                        format = '{load_percent}%  ',
                        update_interval = 5
                        ),
                widget.TextBox(
                       text = '簾',
                       padding = 5,
                       font = 'Mononoki Nerd Font',
                       foreground = colors[2],
                       background = colors[0],
                       fontsize = 16
                       ),
                widget.Memory(
                        font = 'Roboto',
                        fontsize = 14,
                        fmt = '{}',
                        format = '{MemUsed: .0f}{mm}/{MemTotal: .0f}{mm}  ',
                        markup = True,
                        max_chars = 0,
                        measure_mem = 'M',
                        update_interval = 5
                        ),
                widget.TextBox(
                       text = '墳',
                       padding = 5,
                       font = 'Mononoki Nerd Font',
                       foreground = colors[2],
                       background = colors[0],
                       fontsize = 16
                       ),
                widget.Volume(
                       font = 'Roboto',
                       fontsize  = 14,
                       ),
                 widget.TextBox(
                       text = '',
                       font = 'Mononoki Nerd Font',
                       padding = 5,
                       fontsize = 16,
                       ),
                widget.Clock(
                        format='%B %d %a %I:%M %p',
                        font = "Roboto",
                        fontsize = 14,
                        ),
                widget.Systray(),
            ],
            18,
        ),
    ),
]

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),      # tastyworks exit box
    Match(title='Qalculate!'),        # qalculate-gtk
    #Match(wm_class='kdenlive'),       # kdenlive
    Match(wm_class='pinentry-gtk-2'), # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

#wmname = "LG3D"
