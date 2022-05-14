;;; my/notes/autoloads.el -*- lexical-binding: t; -*-

;; Insert a space character
;;;###autoload
(defun k-space nil
  (insert-char 32))

;; Insert the headline prefix
;;;###autoload
(defun k-prefix (&optional s)
  (interactive)
  (or s (setq s "-- "))
  (save-excursion (beginning-of-line) (insert s)))

;; Insert characters to pad line to 80
;;;###autoload
(defun k-suffix (&optional s)
  (interactive)
  (save-excursion
    (end-of-line)
    (or s (progn (k-space)
                 (insert-char 45 (- 80 (current-column)))))))

;; Turn a word into a headline
;;;###autoload
(defun k-headline (&optional a b)
  (interactive)
  (k-prefix a)
  (k-suffix b)
  (evil-open-below 1)
  (evil-normal-state))
