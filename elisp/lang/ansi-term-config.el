;; bash completion
(add-hook 'term-mode-hook (lambda()
        (setq yas-dont-activate t)))

;; kill buffer after exit
(defadvice term-handle-exit
  (after term-kill-buffer-on-exit activate)
(kill-buffer))
