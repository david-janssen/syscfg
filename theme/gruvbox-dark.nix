# Gruvbox dark color scheme

let bg-alt2 = "504945"; in

rec {
  # Name colors
  blue             = "83a598";
  cyan             = "8ec07c";
  dark-blue        = "458588";
  dark-cyan        = "689d6a";
  gray             = "9282374";
  green            = "b8bb26";
  magenta          = "cc241d";
  orange           = "fe8019";
  red              = "fb4934";
  teal             = "8ec07c";
  violet           = "d3869b";
  yellow           = "fabd2f";

  # Background/foreground
  base0            = "0d1011";
  base1            = "1d2021";
  base2            = "282828";
  base3            = "3c3836";
  base4            = "665c54";
  base5            = "7c6f64";
  base6            = "928374";
  base7            = "d5c4a1";
  base8            = "fbf1c7";

  # Functional colors
  bg               = base1;
  comment          = gray;
  constant         = violet;
  fg               = "ebdbb2";
  function         = green;
  keyword          = red;
  method           = green;
  number           = violet;
  operator         = fg;
  selection        = bg-alt2;
  string           = green;
  type             = yellow;
  variable         = blue;

  # emacs-theme
  emacs-theme = "doom-gruvbox";

  # Matching wallpaper
  wallpaper    = ../assets/wallpaper/gruvbox_nixos.png;
}
