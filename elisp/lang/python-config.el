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

(if (eq system-type 'windows-nt)
    (setq python-shell-interpreter "ipython")
(setq python-shell-interpreter "/usr/bin/python3"))

(defcustom lang-python-python-cmd
  " -i "
  "Python cmd arguments"
  :type 'string
  :group 'python
  :safe 'stringp)

(defcustom lang-python-ipython-prompt-setup
  (concat "\"%config PromptManager.in_template = r'{color.LightGreen}>>> '\n"
          "%config PromptManager.in2_template = r'{color.Yellow}>>> '\n"
          "%config PromptManager.out_template = r'{color.LightRed}<<< '\n\"")
  "Customization of ipython prompt"
  :type 'string
  :group 'python
  :safe 'stringp)

(defcustom lang-python-ipython-cmd
  (concat " --no-banner --no-confirm-exit "
          " -c " lang-python-ipython-prompt-setup " "
          " -i ")
  "IPython cmd arguments"
  :type 'string
  :group 'python
  :safe 'stringp)

(defun lang-python-get-cmd ()
  (concat python-shell-interpreter (cond ((string-match "ipython" python-shell-interpreter) lang-python-ipython-cmd)
                                         (t lang-python-python-cmd))))

(defun lang-python-shell-no-prompt (&optional arg)
    (python-shell-get-or-create-process (lang-python-get-cmd) nil t))

(defun lang-python-send-buffer-with-my-args (args)
  (interactive "sPython arguments: ")
  (lang-python-shell-no-prompt)
  (python-shell-send-string (concat "import sys; sys.argv = '''" (buffer-name) " " args "'''.split()\n"))
  (python-shell-send-buffer t))

(defun lang-python-mode-setup ()
  (if (eq system-type 'windows-nt)
      (progn
        (setq exec-path (append exec-path '("C:\\Python35")))
        (setq exec-path (append exec-path '("C:\\Python35\\Scripts")))))
  (jedi:setup)
  (advice-add 'python-shell-send-buffer :before #'lang-python-shell-no-prompt)
  (define-key python-mode-map (kbd "C-c C-c") (lambda () (interactive) (python-shell-send-buffer t)))
  (define-key python-mode-map (kbd "C-c C-b") (lambda () (interactive) (python-shell-send-buffer nil)))
  (define-key python-mode-map (kbd "C-c C-a") 'lang-python-send-buffer-with-my-args)
  (setq split-height-threshold 20)
  (setq split-width-threshold nil))
