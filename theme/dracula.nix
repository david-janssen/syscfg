# Dracula color scheme, taken directly from emacs-doom-themes.

rec {
  # Name colors
  blue             = "61bfff";
  cyan             = "8be9fd";
  dark-blue        = "0189cc";
  dark-cyan        = "8be9fd";
  gray             = "565761";
  green            = "50fa7b";
  magenta          = "ff79c6";
  orange           = "ffb86c";
  red              = "ff5555";
  teal             = "0189cc";
  violet           = "bd93f9";
  yellow           = "f1fa8c";

  # Background/foreground
  base0            = "1e2029";
  base1            = "282a36";
  base2            = "373844";
  base3            = "44475a";
  base4            = "565761";
  base5            = "6272a4";
  base6            = "b6b6b2";
  base7            = "ccccc7";
  base8            = "f8f8f2";

  # Functional colors
  bg               = base1;
  comment          = base5;
  constant         = cyan;
  fg               = base8;
  function         = green;
  keyword          = magenta;
  method           = teal;
  number           = violet;
  operator         = violet;
  selection        = dark-blue;
  string           = yellow;
  type             = violet;
  variable         = magenta;

  # emacs-theme
  emacs-theme = "doom-dracula";

  # Matching wallpaper
  wallpaper    = ./wallpaper/green_mountains.png;
}
