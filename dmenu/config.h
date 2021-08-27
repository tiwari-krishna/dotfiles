
static int topbar = 1;       /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 0;     /* -c option; centers dmenu on screen */
static int min_width = 500;  /* minimum width when centered */
static int fuzzy = 1;        /* -F  option; if 0, dmenu doesn't use fuzzy matching     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Ubuntu:bold:pixelsize=14",
	"NotoMonoRegular:bold:pixelsize=14"
};
static const char *prompt      = {"Run:"};      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#cccccc", "#282a36" },
	[SchemeSel] = { "#ffffff", "#4287f5" },
	[SchemeSelHighlight] = { "#d7d7d7", "#000000" },
	[SchemeNormHighlight] = { "#a5bdf8", "#000000" },
	[SchemeOut] = { "#000000", "#00ffff" },
	[SchemeMid] = { "#d7d7d7", "#1f2026" },
};
/* -l and -g options; controls number of lines and columns in grid if > 0 */
static unsigned int lines      = 0;
static unsigned int lineheight = 22;  /* -h option; minimum height of a menu line */
static unsigned int columns    = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 0;  /* -bw option; to add border width */
