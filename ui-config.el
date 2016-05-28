;; fullscreen function
(defun fullscreen (&optional f)
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

;; maximize on startup
(fullscreen)

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

;; bar cursor
(setq-default cursor-type 'bar)

;; load theme
(load "themes/atom.el")
