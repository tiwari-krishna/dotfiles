//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
    {"  :", "acpi | awk '{print $3 $4 $5}'", 5, 0},
    {"   : ", "bash ~/.dwm/dwmblocks/scripts/volume",    1,         10},
	{"兩 :", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	      2,	  	0},
    {" 漣  ", "bash ~/.dwm/dwmblocks/scripts/cpu",  2 ,   10},

	{"  ", "date '+%b %d %a %I:%M %p'",					60,		0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  |  ";
static unsigned int delimLen = 5;
