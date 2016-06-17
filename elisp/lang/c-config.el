(use-package irony)
(use-package company-c-headers)

(defvar lang-c-make-command "make all")

(defun lang-c-my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'lang-c-my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(defun irony--check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "->") t nil)))))

(defun irony--indent-or-complete ()
  "Indent or Complete"
  (interactive)
  (cond ((and (not (use-region-p))
              (irony--check-expansion))
         (message "complete")
         (company-complete-common))
        (t
         (message "indent")
         (call-interactively 'c-indent-line-or-region))))

(defun irony-mode-keys ()
  "Modify keymaps used by `irony-mode'."
  (local-set-key (kbd "TAB") 'irony--indent-or-complete)
  (local-set-key [tab] 'irony--indent-or-complete))

(defvar lang-c-win32-headers-possible-paths
  (list
   "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include"
   "C:\\Program Files (x86)\\Microsoft Visual Studio 12.0\\VC\\include"
   "C:\\Program Files (x86)\\Microsoft Visual Studio 11.0\\VC\\include"))

(defun lang-c-win32-find-headers-path ()
  (dolist (f lang-c-win32-headers-possible-paths)
    (if (file-exists-p f)
        (return f))))

(defun lang-c-type-mode-setup ()
  (when (eq system-type 'windows-nt)
    (setq w32-pipe-read-delay 0)
    (add-to-list 'company-c-headers-path-system (lang-c-win32-find-headers-path)))
  (message "%s" company-c-headers-path-system)
  (add-to-list 'company-backends '(company-c-headers :with company-yasnippet))
  (add-to-list 'company-backends '(company-irony :with company-yasnippet))
  (irony-mode)
  (set (make-local-variable 'compile-command) lang-c-make-command)
  (define-key c-mode-map (kbd "C-c C-b") (lambda () (interactive) (compile lang-c-make-command)))
  (define-key c++-mode-map (kbd "C-c C-b") (lambda () (interactive) (compile lang-c-make-command)))
  (define-key objc-mode-map (kbd "C-c C-b") (lambda () (interactive) (compile lang-c-make-command)))
  (irony-mode-keys)
  (use-package flycheck
  :commands flycheck-mode
  :init (flycheck-mode)
  :config (progn
            (setq flycheck-check-syntax-automatically '(save mode-enabled))
            (setq flycheck-standard-error-navigation nil)
            (if (eq system-type 'windows-nt)
                (setq flycheck-clang-args "-fms-compatibility-version=19"))
            ;; flycheck errors on a tooltip (doesnt work on console)
            (when (display-graphic-p (selected-frame))
              (eval-after-load 'flycheck
                '(custom-set-variables
                  '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
              )))
  (use-package flycheck-pos-tip)
  (setq split-height-threshold 20)
  (setq split-width-threshold nil))

(defun lang-c-mode-setup ()
  (lang-c-type-mode-setup))

(defun lang-cpp-mode-setup ()
  (lang-c-type-mode-setup))

(defun lang-objc-mode-setup ()
  (lang-c-type-mode-setup))
