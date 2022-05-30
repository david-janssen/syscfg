;;; ~/opt/dotfiles/dotfiles/.config/doom/+haskell.el -*- lexical-binding: t; -*-
(after! haskell

  (defalias 'haskell-align-record
    (kmacro "v i { C-e : : <return> C-e - - <return> <esc>"))

  ;; Basic config -------------------------------------------------------------

  ;; We rely on lorri to make sure that ghci points to the right executable
  (setq haskell-process-type 'cabal-repl)

  ;; Exclude session buffer from popups ---------------------------------------

  ;; Prefix all haskell-session buffers with 'ih-'
  (defun haskell-session-default-name ()
    "Generate a default project name for the new project prompt."
    (let ((file (haskell-cabal-find-file)))
      (seq-concatenate 'string "ih-"
                       (or (when file
                             (downcase (file-name-sans-extension
                                        (file-name-nondirectory file))))
                           "haskell"))))

  ;; Exclude all 'ih-' buffers from popup-management
  (set-popup-rule! "^\*ih-.*" :ignore t)

  ;; Disable company-mode, more annoying than useful ---------------------------
  (add-hook 'haskell-mode-hook (lambda () (company-mode 0)))

  ;; Configure LSP
  (setq
   lsp-haskell-plugin-import-lens-code-lens-on nil
   lsp-headerline-breadcrumb-enable            t
   )

  ;; Customize haskell keybindings ---------------------------------------------
  (map!
   :map haskell-mode-map
   :nv "]e" #'flycheck-next-error
   :nv "[e" #'flycheck-previous-error
   (:leader
    :desc "repl-load-file" "mm" #'haskell-process-clear-and-process
    :desc "repl-clear"     "md" #'haskell-interactive-mode-clear
    :desc "align-record"   "mr" #'haskell-align-record

    :desc "lsp-ui-doc-show" "ld"          #'lsp-ui-doc-show
    :desc "lsp-goto-type-definition" "lj" #'lsp-goto-type-definition
    :desc "lsp-avy-lens"             "ll" #'lsp-avy-lens)))
