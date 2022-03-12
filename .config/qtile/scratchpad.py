from os import environ

from libqtile.config import ScratchPad, DropDown, Key
from libqtile.command import lazy

class Scratchpad(object):

	def init_scratchpad(self):

		# Terminal
		# terminal = environ.get("TERMINAL_SOLO")
		terminal = "st"
		calculator= "galculator"

		# Configuration
		height =				0.850
		y_position =			0.0751
		warp_pointer =			False
		on_focus_lost_hide =	True
		opacity =				1

		return [
			ScratchPad("SPD",
				dropdowns = [
					# Drop down terminal with tmux session
					DropDown("term",
						terminal,
						opacity = opacity,
						y = y_position,
						height = height,
						on_focus_lost_hide = on_focus_lost_hide,
						warp_pointer = warp_pointer),

					# Another terminal exclusively for music player
					DropDown("music",
						terminal + " -e ncmpcpp",
						opacity = opacity,
						y = y_position,
						height = height,
						on_focus_lost_hide = on_focus_lost_hide,
						warp_pointer = warp_pointer),

					# Another terminal exclusively for qshell
					DropDown("calc",
						calculator,
						opacity = opacity,
						y = y_position,
						height = height,
						on_focus_lost_hide = on_focus_lost_hide,
						warp_pointer = warp_pointer)
				]
			),
		]

class DropDown_Keys(object):

	##### DROPDOWNS KEYBINDINGS #####

	def init_dropdown_keybindings(self):

		# Key alias
		mod =	"mod4"

		return [
			Key([mod, "shift"], "Return",
				lazy.group["SPD"].dropdown_toggle("term")),
			Key([mod, "shift"], "m",
				lazy.group["SPD"].dropdown_toggle("music")),
			Key([mod], "z",
				lazy.group["SPD"].dropdown_toggle("calc")),
		]

# vim: tabstop=4 shiftwidth=4 noexpandtab
