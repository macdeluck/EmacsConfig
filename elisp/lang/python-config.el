(defun lang-python-init ()
  (use-package jedi))

(defun lang-python-filename-fix (orig-fun &rest args)
      ;;(message "Python called with args: %s" args)
      (let ((in-path1 (nth 1 args))
            (in-path2 (nth 5 args)))
        (if in-path1
            (setf (nth 1 args) (replace-regexp-in-string (regexp-quote "\\") (regexp-quote "/") in-path1)))
        (if in-path2
            (setf (nth 5 args) (replace-regexp-in-string (regexp-quote "\\") (regexp-quote "/") in-path2))))
      ;;(message "Python call replaced with args: %s" args)
      (apply orig-fun args))

(defun lang-python-shell-send-buffer-no-prompt (&optional arg)
  (python-shell-get-or-create-process "python -i" nil t))

(defun lang-python-mode-setup ()
  (if (eq system-type 'windows-nt)
      (progn
        (setq exec-path (append exec-path '("C:\\Python35")))
        (setq exec-path (append exec-path '("C:\\Python35\\Scripts")))))
  (jedi:setup)
  (advice-add 'python-shell-send-buffer :before #'lang-python-shell-send-buffer-no-prompt)
  (define-key python-mode-map (kbd "C-c C-c") (lambda () (interactive) (python-shell-send-buffer t)))
  (define-key python-mode-map (kbd "C-c C-b") (lambda () (interactive) (python-shell-send-buffer nil)))
  (setq split-height-threshold 20)
  (setq split-width-threshold nil))

      ;; setup windows
;    (let ((num-of-buffers (count-buffers)))
;      (message "Number of buffers is %s" (number-to-string num-of-buffers))
;      (if (< num-of-buffers 2)
;          (split-window-vertically -20)))
 ;   (if (not (get-buffer "*IPython*"))
 ;       (progn
 ;         (message "Creating new IPython buffer")
 ;         (ipython)))
 ;   (next-multiframe-window)
 ;   (switch-to-buffer "*IPython*")
 ;   (previous-multiframe-window)


    ;;(message "Python windows split style: %s" py-split-window-on-execute)

    ;; switch to the interpreter after executing code
                                        ;(setq py-shell-switch-buffers-on-execute-p nil)
                                        ;(setq py-switch-buffers-on-execute-p nil)
    ;; don't split windows
;    (setq py-split-windows-on-execute-p nil)
;    ;; try to automagically figure out indentation
;                                        ;(setq py-smart-indentation t)

;    (use-package jedi)
;
 ;   (jedi:setup)
                                        ;  (setq jedi:complete-on-dot t))
