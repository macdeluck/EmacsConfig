;; fullscreen function
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; hide toolbar
(if window-system
    (tool-bar-mode -1))

;; window title
(setq frame-title-format "Emacs (%b)")

;; fill collumn indicator
(use-package fill-column-indicator)
(if (not (boundp 'fci-mode))
	(error "fci-mode undefined"))
(define-globalized-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)
(setq fci-rule-column 80)
(setq fci-rule-color "#3E4451")
(load "fci-mode-fix.el")

;; bar cursor
(setq-default cursor-type 'bar)

;; load theme
(if window-system
    (load "themes/atom.el")
  (load "themes/subatomic256-theme.el")
  (require 'color)
  
  (let ((bg (face-attribute 'default :background)))
    (custom-set-faces
     `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
;     `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
;     `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
     `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
     `(company-tooltip-common ((t (:inherit font-lock-constant-face)))))))
