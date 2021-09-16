# tomorrow-night color scheme, taken directly from emacs-doom-themes.

rec {
  # Name colors
  blue        = "81a2be";
  cyan        = "8abeb7";
  dark-blue   = "41728e";
  dark-cyan   = "52726d";
  gray        = "5a5b5a";
  green       = "b5bd68";
  magenta     = "c9b4cf";
  orange      = "de935f";
  red         = "cc6666";
  teal        = "7aa6da";
  violet      = "b294bb";
  yellow      = "f0c674";

  # Background/foreground
  base0       = "0d0d0d";
  base1       = "1b1b1b";
  base2       = "212122";
  base3       = "292b2b";
  base4       = "3f4040";
  base5       = "5c5e5e";
  base6       = "757878";
  base7       = "969896";
  base8       = "ffffff";

  # Functional colors
  bg          = "1d1f21";
  comment     = gray;
  constant    = orange;
  fg          = "c5c8c6";
  function    = blue;
  keyword     = violet;
  method      = blue;
  number      = orange;
  operator    = fg;
  selection   = "333537";
  string      = green;
  type        = yellow;
  variable    = red;

  # emacs-theme
  emacs-theme = "doom-tomorrow-night";

  # Matching wallpaper
  wallpaper   = ./wallpaper/sailing.png;
}
