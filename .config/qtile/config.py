from typing import List
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.command import lazy
from scratchpad import Scratchpad, DropDown_Keys
#from libqtile.utils import guess_terminal

mod = "mod4"
terminal = "st"
browser1 = "qutebrowser"
browser2 = "brave"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod, "control"], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # window size management(monadtall)
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "control"], "l", lazy.layout.grow(),
        desc="Inc Window size"),
    Key([mod, "control"], "h", lazy.layout.shrink(),
        desc="Dec Window size"),
    Key([mod, "control"], "n", lazy.layout.normalize(),
        desc="normal window size"),
    Key([mod, "control"], "m", lazy.layout.maximize(),
        desc="Maximize"),
    Key([mod, "shift"], "space", lazy.layout.flip(),
        desc="flip M/S placement"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    #Key([mod, "control"], "h", lazy.layout.grow_left(),
    #    desc="Grow window to the left"),
    #Key([mod, "control"], "l", lazy.layout.grow_right(),
    #    desc="Grow window to the right"),
    #Key([mod, "control"], "j", lazy.layout.grow_down(),
    #    desc="Grow window down"),
    #Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    #Key([mod, "shift"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "control"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen(), desc="Fullscreen"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="floating"),
    Key([mod, "control"], "q", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

layout_theme = {"border_width": 2,
                "margin": 5,
                "border_focus": "#002efc",
                "border_normal": "#fc0000"
               }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Matrix(**layout_theme),
    layout.Stack(**layout_theme,num_stacks=2),
    #layout.Tile(**layout_theme),
    #layout.Columns(**layout_theme),
    #layout.Slice(**layout_theme),
    layout.Max(),
    layout.Floating(),
    # Try more layouts by unleashing below layouts.
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='Noto Sans',
    fontsize=14,
    padding=2,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.AGroupBox(),
                widget.GroupBox(
                    font='Ubuntu Mono',
                    fontsize=14,
                    hide_unused=True,
                    highlight_method='line',
                    highlight_color=['#b81818', '#b81818'],
                    block_highlight_text_color='#ffffff',
                    ),
                widget.Prompt(),
                widget.TextBox("|", name="default"),
                #widget.CurrentLayout(),
                widget.CurrentLayoutIcon(),
                widget.TextBox("|", name="default"),
                #widget.WindowName(),
                widget.WindowName(
                    foreground='#ffaa00',
                    fontsize=13,
                    ),
                widget.TextBox("|", name="default"),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # widget.TextBox("default config", name="default"),
                # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                widget.TextBox("🔋", name="time", font='Noto Color Emoji', fontsize='13'),
                widget.Battery(
                    format='{char} {percent:2.0%} ⚡ {hour:d}:{min:02d} ',
                    charge_char='Charging',
                    discharge_char='Dischar',
                    unknown_char='Unk',
                    update_interval='30',
                    show_short_text=True,
                    full_char='Full'
                    ),
                widget.TextBox("🔊", name="time", font='Noto Color Emoji', fontsize='13'),
                widget.PulseVolume(
                    ),
                widget.Wttr(
                    location={
                            'Kawasoti': 'Kawasoti',
                            '27.641983229860763,84.11660671234132': 'Kawasoti',
                             },
                    #location="Kawasoti",
                    format='%c %C 🌡️ %t(%f)  %m %M ☔ %p',
                    units='m',
                    update_interval=900,
                    ),
                widget.TextBox("📶", name="time", font='Noto Color Emoji', fontsize='13'),
                widget.Wlan(
                    format='{percent:2.0%}',
                    interface='wlan0',
                    update_interval='30',
                    ),
                widget.TextBox("💾", name="time", font='Noto Color Emoji', fontsize='13'),
                widget.Memory(
                    update_interval=5),
                #widget.Net(
                #    format='⬇ {down} ⬆ {up}',
                #    interface='wlan0',
                #),
                widget.Notify(),
                #widget.TextBox("🌡", name="time", font='Noto Color Emoji', fontsize='13'),
                #widget.ThermalSensor(),
                #widget.Pacman(
                #    update_interval="28800",
                #),
                widget.TextBox("📅", name="time", font='Noto Color Emoji', fontsize='13'),
                widget.Clock(format='%b %d %a'),
                widget.TextBox("🕐", name="time", font='Noto Color Emoji', fontsize='13'),
                widget.Clock(format='%I:%M %p'),
                widget.Systray(),
                # widget.QuickExit(),
            ],
            18,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

obj_scratchpad = Scratchpad()
obj_dd_keys = DropDown_Keys()

groups += obj_scratchpad.init_scratchpad()
keys += obj_dd_keys.init_dropdown_keybindings()

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
