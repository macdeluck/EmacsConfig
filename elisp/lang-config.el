;; use snippets
(use-package yasnippet)
(yas-global-mode 1)

;; load ansi term
(load "lang/ansi-term-config")

;; load python
(load "lang/python-config")
(lang-python-init)
(add-hook 'python-mode-hook 'lang-python-mode-setup)
