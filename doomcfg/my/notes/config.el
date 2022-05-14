;;; my/notes/config.el -*- lexical-binding: t; -*-

;; Different regexp's and how to color them
(setq note-highlights
 '(;; A line of 80 dashes
   ("^-\\{80,80\\}"           . 'font-lock-doc-face)
   ;; A line starting with `-- `
   ("^-- \\ca*? -+"           . 'font-lock-constant-face)
   ;; A `some-type_` statement
   ("[a-z]+\\(\\-[a-z]+\\)*_" . 'font-lock-function-name-face)))

;; Define a new major-mode with Emacs
(define-derived-mode note-mode markdown-mode "notes"
  "major mode for editing my own note-syntax"
  (setq font-lock-defaults '(note-highlights)))

