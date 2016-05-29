(if (eq system-type 'windows-nt)
    (progn
      (setq exec-path (append exec-path '("C:\\Python35")))
      (setq exec-path (append exec-path '("C:\\Python35\\Scripts")))
      ))      

;; python mode
(use-package python-mode)

;; python env
(use-package python-environment)

(setq
 py-default-interpreter "ipython3"
 python-shell-interpreter "ipython3"
 py-which-bufname "IPython"
 python-shell-interpreter-args "--colors=Linux --profile=default"
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 py-python-command-args "--gui=wx --pylab=wx -colors Linux"
 py-ipython-command-args "")

(defun python-ipython-filename-fix (orig-fun &rest args)
  (message "Python called with args: %s" args)
  (let ((in-path1 (nth 1 args))
        (in-path2 (nth 5 args)))
    (if in-path1
        (setf (nth 1 args) (replace-regexp-in-string (regexp-quote "\\") (regexp-quote "/") in-path1)))
    (if in-path2
        (setf (nth 5 args) (replace-regexp-in-string (regexp-quote "\\") (regexp-quote "/") in-path2))))
  (message "Python call replaced with args: %s" args)
  (apply orig-fun args))

(if (eq system-type 'windows-nt)
    (progn
      (custom-set-variables '(py-shell-name "ipython3"))
      (custom-set-variables '(py-ipython-command-args ""))
      (advice-add 'py-which-execute-file-command :around #'python-ipython-filename-fix )
      (advice-add 'py--execute-file-base :around #'python-ipython-filename-fix)))
; python-shell-completion-setup-code
; "from IPython.core.completerlib import module_completion"
; python-shell-completion-module-string-code
; "';'.join(module_completion('''%s'''))\n"
; python-shell-completion-string-code
; "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

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
