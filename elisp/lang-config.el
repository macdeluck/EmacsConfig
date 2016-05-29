;; use snippets
(use-package yasnippet)
(yas-global-mode 1)

;; load ansi term
(load "lang/ansi-term-config")

;; load python
(defun lang-python-mode-setup ()
    (load "lang/python-config"))
(add-hook 'python-mode-hook 'lang-python-mode-setup)
