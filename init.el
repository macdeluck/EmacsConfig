;; append path
(add-to-list 'load-path "~/.emacs.d/elisp")

;; use package
(load "use-package.el")

;; load package archives
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
  (add-to-list 'package-archives '("elpy" . "http://jorgenschaefer.github.io/packages/") t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (package-initialize))

;; set startup buffer as scratch
(setq inhibit-splash-screen t)
(switch-to-buffer "**")

;; load defs
(load "xdefs-config")

;; load editor config
(load "editor-config")

;; load ui config
(load "ui-config")

;; load languages config
(load "lang-config")
