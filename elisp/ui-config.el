;; fullscreen function
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; hide toolbar
(tool-bar-mode -1)

;; window title
(setq frame-title-format "Emacs (%b)")

;; fill collumn indicator
(use-package fill-column-indicator)
(define-globalized-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)
(setq fci-rule-column 80)
(setq fci-rule-color "#3E4451")
(load "fci-mode-fix.el")

;; bar cursor
(setq-default cursor-type 'bar)

;; load theme
(load "themes/atom.el")
