# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from color import colors

mod = "mod4"
terminal = guess_terminal()

# fmt: off
keys = [
    Key([mod],              "h",      lazy.layout.left(),                 desc="Move focus to left"),
    Key([mod],              "l",      lazy.layout.right(),                desc="Move focus to right"),
    Key([mod],              "j",      lazy.layout.down(),                 desc="Move focus down"),
    Key([mod],              "k",      lazy.layout.up(),                   desc="Move focus up"),
    Key([mod],              "space",  lazy.layout.next(),                 desc="Move window focus to other window"),
    Key([mod, "shift"],     "h",      lazy.layout.shuffle_left(),         desc="Move window to the left"),
    Key([mod, "shift"],     "l",      lazy.layout.shuffle_right(),        desc="Move window to the right"),
    Key([mod, "shift"],     "j",      lazy.layout.shuffle_down(),         desc="Move window down"),
    Key([mod, "shift"],     "k",      lazy.layout.shuffle_up(),           desc="Move window up"),
    Key([mod, "control"],   "h",      lazy.layout.grow_left(),            desc="Grow window to the left"),
    Key([mod, "control"],   "l",      lazy.layout.grow_right(),           desc="Grow window to the right"),
    Key([mod, "control"],   "j",      lazy.layout.grow_down(),            desc="Grow window down"),
    Key([mod, "control"],   "k",      lazy.layout.grow_up(),              desc="Grow window up"),
    Key([mod],              "n",      lazy.layout.normalize(),            desc="Reset all window sizes"),
    Key([mod, "shift"],     "Return", lazy.layout.toggle_split(),         desc="Toggle between split and unsplit sides of stack"),
    Key([mod],              "Return", lazy.spawn(terminal),               desc="Launch terminal"),
    Key([mod],              "Tab",    lazy.next_layout(),                 desc="Toggle between layouts"),
    Key([mod],              "w",      lazy.window.kill(),                 desc="Kill focused window"),
    Key([mod],              "f",      lazy.window.toggle_fullscreen(),    desc="Toggle fullscreen on the focused window"),
    Key([mod],              "t",      lazy.window.toggle_floating(),      desc="Toggle floating on the focused window"),
    Key([mod, "control"],   "r",      lazy.reload_config(),               desc="Reload the config"),
    Key([mod, "control"],   "q",      lazy.shutdown(),                    desc="Shutdown Qtile"),
    Key([mod],              "r",      lazy.spawncmd(),                    desc="Spawn a command using a prompt widget"),
]
# fmt: on

groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    layout.Columns(
        border_width=2,
        border_focus=colors["magenta"],
        border_focus_stack=colors["magenta"],
        border_normal=colors["green"],
        border_normal_stack=colors["green"],
        border_on_single=True,
        margin=4,
        margin_on_single=4,
    ),
    layout.Max(),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=12,
    padding=3,
    foreground=colors["fg"],
    background=colors["bg"],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.Sep(),
                widget.GroupBox(
                    active=colors["magenta"],
                    highlight_method="line",
                    borderwidth=2,
                    this_current_screen_border=colors["magenta"],
                    this_screen_border=colors["magenta"],
                    highlight_color=[colors["black"], colors["black"]],
                    fmt="{}",
                ),
                widget.Sep(),
                widget.Prompt(),
                widget.Sep(),
                widget.WindowName(),
                widget.Sep(),
                widget.Systray(),
                widget.Sep(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.Sep(),
                widget.QuickExit(),
            ],
            24,
        ),
    ),
]

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True

wl_input_rules = None
wl_xcursor_theme = None
wl_xcursor_size = 24

wmname = "LG3D"
