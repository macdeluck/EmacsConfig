(use-package cl-lib)

;; no bell sound
(setq visible-bell 1)

;; tab size
(custom-set-variables '(tab-width 4))
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; set tab for indentation
(setq-default indent-tabs-mode nil)

;; require ido mode
(use-package ido)
(ido-mode t)

;; recent files
(use-package recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 10)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; disable backup
(setq backup-inhibited t)

;; turn of autosave
(setq auto-save-default nil)

;; show line numbers
(load "linum-config")
(define-globalized-minor-mode
  global-nlinum-mode linum-mode (lambda () (linum-mode 1)))
(global-linum-mode t)

;; match parenthesis
(show-paren-mode 1)
;; show in minibuffer line of matched paren
(defadvice show-paren-function
      (after show-matching-paren-offscreen activate)
      "If the matching paren is offscreen, show the matching line in the
        echo area. Has no effect if the character before point is not of
        the syntax class ')'."
      (interactive)
      (let* ((cb (char-before (point)))
             (matching-text (and cb
                                 (char-equal (char-syntax cb) ?\) )
                                 (blink-matching-open))))
        (when matching-text (message matching-text))))

;; no show parenthesis delay
(setq show-paren-delay 0)

;; enable tree view
(use-package neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)

;; use CTRL-Tab buffer cycle
(load "buffer-stack")
(global-set-key [C-tab] 'buffer-stack-bury)

(defun my-save-buffers-kill-emacs (&optional arg)
  "Offer to save each buffer(once only), then kill this Emacs process.
With prefix ARG, silently save all file-visiting buffers, then kill."
  (interactive "P")
  (save-some-buffers arg t)
  (and (or (not (fboundp 'process-list))
       ;; process-list is not defined on MSDOS.
       (let ((processes (process-list))
         active)
         (while processes
           (and (memq (process-status (car processes)) '(run stop open listen))
            (process-query-on-exit-flag (car processes))
            (setq active t))
           (setq processes (cdr processes)))
         (or (not active)
         (progn (list-processes t)
            (yes-or-no-p "Active processes exist; kill them and exit anyway? ")))))
       ;; Query the user for other things, perhaps.
       (run-hook-with-args-until-failure 'kill-emacs-query-functions)
       (or (null confirm-kill-emacs)
       (funcall confirm-kill-emacs "Really exit Emacs? "))
       (kill-emacs)))

(defun my-save-buffers-kill-emacs-advice (orig-fun &optional args)
  (my-save-buffers-kill-emacs))

(advice-add 'save-buffers-kill-emacs :around #'my-save-buffers-kill-emacs-advice)

;; ALT-F4 to kill emacs (windows compatibility)
(global-set-key [M-f4] 'save-buffers-kill-terminal)

;; set default directory to home
(setq default-directory (getenv "HOME"))

;; replace instead of search backward
(global-unset-key (kbd "C-r"))
(global-set-key (kbd "C-r C-r") 'query-replace-regexp-current-symbol)
(global-set-key (kbd "C-r C-s") 'isearch-backward)

;; distinguish C-m and RET
(if window-system
	(define-key input-decode-map [?\C-m] [C-m]))
