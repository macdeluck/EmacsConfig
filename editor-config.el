(use-package cl-lib)

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

;; auto completion
(semantic-mode)
(use-package auto-complete)
(use-package auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-delay 0.5)

;; show line numbers
(load "linum-config")
(define-globalized-minor-mode
  global-nlinum-mode linum-mode (lambda () (linum-mode 1)))
(global-linum-mode t)

;; match parenthesis
(show-paren-mode 1)

;; no show parenthesis delay
(setq show-paren-delay 0)

;; enable tree view
(use-package neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)

;; use CTRL-Tab buffer cycle
(load "buffer-stack")
(global-set-key [C-tab] 'buffer-stack-bury)

;; don't ask to kill when process is alive in buffer
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))
