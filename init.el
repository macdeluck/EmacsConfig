;; append path
(add-to-list 'load-path "~/.emacs.d/")

;; load package archives
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; set startup buffer as scratch
(setq inhibit-splash-screen t)
(switch-to-buffer "**")

;; use package
(load "use-package.el")

;; load editor config
(load "editor-config")

;; load ui config
(load "ui-config")

;; load languages config
(load "lang-config")
