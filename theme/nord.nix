# Nord color scheme, taken directly from emacs-doom-themes.

rec {
  # Name colors
  blue             = "81a1c1";
  cyan             = "88c0d0";
  dark-blue        = "5e81ac";
  dark-cyan        = "507681";
  gray             = base4;
  green            = "a3be8c";
  magenta          = "b48ead";
  orange           = "d08770";
  red              = "bf616a";
  teal             = "8fbcbb";
  violet           = "5d80ae";
  yellow           = "ebcb8b";

  # Background/foreground
  base0            = "191c25";
  base1            = "242832";
  base2            = "2c333f";
  base3            = "373e4c";
  base4            = "434c5e";
  base5            = "4c566a";
  base6            = "9099ab";
  base7            = "d8dee9";
  base8            = "f0f4fc";

  # Functional colors
  bg               = base2;
  comment          = dark-cyan;
  constant         = blue;
  fg               = "e5e9f0";
  function         = cyan;
  keyword          = blue;
  method           = cyan;
  number           = magenta;
  operator         = blue;
  selection        = dark-blue;
  string           = green;
  type             = teal;
  variable         = base7;

  # emacs-theme
  emacs-theme = "doom-nord";
  # kitty-theme = "nord"; kitty themes don't work at the moment

  # Matching wallpaper
  wallpaper    = ../assets/wallpaper/cold.png;
}
