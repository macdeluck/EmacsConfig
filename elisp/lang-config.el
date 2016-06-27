;; use snippets
(use-package yasnippet)
(yas-global-mode 1)

;; autocomplete
(use-package company)
(use-package company-quickhelp)
(setq company-idle-delay 0)
(setq company-quickhelp-delay 1)
(global-set-key (kbd "C-.") 'company-complete-common)
(if window-system
    (global-set-key (kbd "C-,") #'company-quickhelp-manual-begin))

(global-company-mode)
(if window-system
    (company-quickhelp-mode))

(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas)
          (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

;; load ansi term
(load "lang/ansi-term-config")

;; load python
(load "lang/python-config")
(lang-python-init)
(add-hook 'python-mode-hook 'lang-python-mode-setup)

;; load cpp
(load "lang/c-config")
(add-hook 'c++-mode-hook 'lang-cpp-mode-setup)
(add-hook 'c-mode-hook 'lang-c-mode-setup)
(add-hook 'objc-mode-hook 'lang-objc-mode-setup)
