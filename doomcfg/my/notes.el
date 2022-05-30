;;; -*- lexical-binding: t; -*-
;;;
;;; Interestingly, if I name this buffer "org.el" and I (load! my/org), I get
;;; weird emacs initialization errors.

(defun my-org-agenda () (interactive) "Load my agenda" (org-agenda nil "a"))

(defconst my-org-dir   "/home/david/dcs/notes/")
(defconst my-init-file (concat my-org-dir "init.org"))

(after! org

  (add-hook 'org-mode-hook (lambda () (auto-fill-mode)))

  (setq
   ;; Disable org logging
   ;; General org stuff
   org-directory        my-org-dir
   org-ellipsis         " ▼ "
   org-startup-folded   nil
   org-startup-indented t
   org-tags-column      -80

   ;; TODOS --------------------------------------------------------------------

   ;; Keep track of state-changes, but hide them in a drawer
   org-log-into-drawer nil

   ;; Which keywords we support
   org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "SOON(s)" "|" "DONE(d)")
                       (sequence "WAIT(w)" "|" "CANCELED(c)"))

   ;; AGENDA -------------------------------------------------------------------

   ;; What files we use for our agenda
   org-agenda-files       `(,my-init-file)
   org-agenda-file-regexp "\\`[^.].*\\(\\.org\\|\\.note\\)\\'"

   ;; What we want our agenda to display
   org-agenda-custom-commands
   '(("t" "today"
      ((agenda
        ""
        ((org-agenda-span 1)
         (org-agenda-start-day "0d")))
       (todo "NEXT" ((org-agenda-overriding-header "Next actions")))
       (todo "TODO" ((org-agenda-overriding-header "Tasks")))))
     ("w" "week"
      ((agenda
        ""
        ((org-agenda-span 7)
         (org-agenda-start-day "0d"))))))

  ;; CAPTURE -------------------------------------------------------------------

  ;; Where capture writes to
  org-default-notes-file my-init-file

  ;; Setting up org-capture
  org-capture-templates
  '(;; Capture general todo entries
    ("t" "todo" entry (file+olp "" "tasks")
     "* TODO %?\n"
     :kill-buffer t)

    ("n" "next" entry (file+olp "" "tasks")
     "* NEXT %?\n"
     :kill-buffer t)

    ("d" "on day" entry (file+olp "" "tasks")
     "* TODO %?\nscheduled: %^t\n"
     :kill-buffer t)

    ("i" "on time" entry (file+olp "" "tasks")
     "* TODO %?\nscheduled: %^T\n"
     :kill-buffer t))

  ;; REFILE --------------------------------------------------------------------

  org-refile-targets '((org-agenda-files :maxlevel . 3)))

  )
