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
 py-python-command-args '("--gui=wx" "--pylab=wx" "-colors" "Linux"))

(defun python-ipython-filename-fix (orig-fun &rest args)
  ;;(message "Python called with args: %s" args)
  (let ((in-path1 (nth 1 args))
        (in-path2 (nth 5 args)))
    (if in-path1
        (setf (nth 1 args) (replace-regexp-in-string (regexp-quote "\\") (regexp-quote "/") in-path1)))
    (if in-path2
        (setf (nth 5 args) (replace-regexp-in-string (regexp-quote "\\") (regexp-quote "/") in-path2))))
  ;;(message "Python call replaced with args: %s" args)
  (apply orig-fun args))

(if (eq system-type 'windows-nt)
  (progn
    (custom-set-variables '(py-shell-name "ipython3"))
    (advice-add 'py-which-execute-file-command :around #'python-ipython-filename-fix )
    (advice-add 'py--execute-file-base :around #'python-ipython-filename-fix)))

(custom-set-variables '(py-ipython-command-args "--no-banner --no-confirm-exit"))
;(custom-set-variables '(py-split-windows-on-execute-function nil))
;(custom-set-variables '(py-split-window-on-execute nil))

;; setup windows
(use-package bs)
(let ((num-of-buffers (count-buffers)))
  (message "Number of buffers is %s" (number-to-string num-of-buffers))
  (if (< num-of-buffers 2)
      (split-window-vertically -20)))
(if (not (get-buffer "*IPython*"))
    (progn
      (message "Creating new IPython buffer")
      (ipython)))
(next-multiframe-window)
(switch-to-buffer "*IPython*")
(previous-multiframe-window)

;;(message "Python windows split style: %s" py-split-window-on-execute)

;; switch to the interpreter after executing code
                                    ;(setq py-shell-switch-buffers-on-execute-p nil)
                                    ;(setq py-switch-buffers-on-execute-p nil)
;; don't split windows
                                    ;(setq py-split-windows-on-execute-p nil)
;; try to automagically figure out indentation
                                    ;(setq py-smart-indentation t)

(use-package jedi)

(jedi:setup)
(setq jedi:complete-on-dot t)
