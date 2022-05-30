;;; ../../prj/syscfg/doomcfg/autoload/sections.el -*- lexical-binding: t; -*-

;;; my/notes/autoloads.el -*- lexical-binding: t; -*-

;; Insert a space character
;;;###autoload
(defun s-space nil
  (insert-char 32))

;; Insert the headline prefix
;;;###autoload
(defun s-prefix (&optional s)
  (interactive)
  (or s (setq s "-- "))
  (save-excursion (beginning-of-line) (insert s)))

;; Insert characters to pad line to 80
;;;###autoload
(defun section-suffix (&optional s)
  (interactive)
  (save-excursion
    (end-of-line)
    (or s (progn (s-space)
                 (insert-char ?- (- 80 (current-column)))))))

;; Turn a word into a headline
;;;###autoload
(defun section-headline (&optional a b)
  (interactive)
  (s-prefix a)
  (section-suffix b)
  (evil-open-below 1)
  (evil-normal-state))
