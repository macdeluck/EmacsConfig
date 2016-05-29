(if (eq system-type 'windows-nt)
    (progn
      (setq exec-path (append exec-path '("C:\\Python35")))
      (setq exec-path (append exec-path '("C:\\Python35\\Scripts")))
      ))      

;; python mode
(use-package python-mode)

;; python env
(use-package python-environment)

;(setq-default py-shell-name "ipython")
;(setq-default py-which-bufname "IPython")
;; use the wx backend, for both mayavi and matplotlib
;(setq py-python-command-args
;  '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
;(setq py-force-py-shell-name-p t)

;; switch to the interpreter after executing code
;(setq py-shell-switch-buffers-on-execute-p nil)
;(setq py-switch-buffers-on-execute-p nil)
;; don't split windows
;(setq py-split-windows-on-execute-p nil)
;; try to automagically figure out indentation
;(setq py-smart-indentation t)

(use-package jedi)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
;(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)
