;; Count buffers
(defun count-buffers (&optional frame)
  "Count how many buffers are currently being shown. Defaults to selected frame."
  (length (mapcar #'window-buffer (window-list frame))))

(defun query-replace-regexp-current-symbol (regex to-string)
  "Works the same as query-replace-regexp but inserts current symbol as start text to search"
  (interactive (list
                (read-string "Regex to search: " (thing-at-point 'symbol))
                (read-string "String to replace: " (thing-at-point 'symbol)))); (concat "sRegex to search: " (thing-at-point 'symbol) "\nsString to replace: "))
  (save-excursion
    (goto-char (point-min))
    (query-replace-regexp regex to-string)))

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))
