;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq
  ;; Personal information
  user-full-name    "David Janssen"
  user-mail-address "janssen.dhj@gmail.com"

  ;; Set fonts
  doom-font                (font-spec :family "Fira Code" :size 14)
  doom-variable-pitch-font (font-spec :family "Fira Code" :size 14)
  doom-big-font            (font-spec :family "Fira Code" :size 16)

  ;; Allow all themes to be loaded safely
  custom-file        "./.custom.el"
  custom-safe-themes t

  projectile-project-search-path '("~/prj/" "~/opt")

  ;; Turn indentation into something sane
  electric-indent-inhibit   t

  evil-snipe-scope          'whole-visible
  evil-escape-key-sequence  nil

  ;; Configure HTML indentation
  web-mode-markup-indent-offset 2

  browse-url-browser-function #'browse-url-chromium

  auth-sources '("~/.authinfo.gpg")

  confirm-kill-emacs nil

  )
(setf (alist-get ?- +ligatures-composition-alist)
  (regexp-opt '("-->" "--->" "->-" "-<" "-<-" "-<<" "->" "->>" "-}" "-~" "-:" "-|")))

;; Configure folding
(vimish-fold-global-mode 1) ; Enable persistent folds

(remove-hook 'text-mode-hook #'spell-fu-mode)

;; Configure company-times
(after! company
  (setq company-idle-delay nil
        company-echo-delay .5
        company-minimum-prefix-length 3))
;; Configure magit
(after! magit
  ;; Hides closed topics
  (setq forge-topic-list-limit '(60 . 0)))

;; Add section and subsection todo highlighting
(after! hl-todo
  (setq hl-todo-keyword-faces
        '(("NOTE" success bold)
          ("TODO" warning bold)
          ("SOON" warning bold)
          ("HACK" font-lock-constant-face bold)
          ("BUG" error bold)
          ("FIXME" error bold)
          ("SECTION" font-lock-type-face bold)
          ("SUBSECTION" font-lock-keyword-face bold)
          ("SUBSUBSECTION" font-lock-builtin-face bold)
          ("WHY" success bold)
          ("HOW" font-lock-constant-face bold)
          ("WHAT" font-lock-type-face bold)
          ("HEADER" success bold)
          )))


;; Disable global checking
(global-flycheck-mode 'disable)
(add-hook 'prog-mode-hook (lambda () (flyspell-mode-off)))

(load! "my/haskell")
(load! "my/notes")
(load! "my/theme")
(load! "my/keymap")       ;; Be sure this is the last thing we do
