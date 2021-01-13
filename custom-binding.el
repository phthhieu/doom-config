;; To go to previous buffer pretty easy
(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))
(global-set-key (kbd "C-<backspace>") 'switch-to-last-buffer)

;; Custom bindings
;; Easy motion with a single s
(setq avy-all-windows t)
(map! :nv "s" #'evil-avy-goto-char-timer)

(defun w/projectile-file-path ()
  "Retrieve the file path relative to project root.
Returns:
  - A string containing the file path in case of success.
  - `nil' in case the current buffer does not visit a file."
  (when-let (file-name (buffer-file-name))
    (file-relative-name (file-truename file-name) (projectile-project-root))))

(defun w/projectile-copy-file-path ()
  "Copy and show the file path relative to project root."
  (interactive)
  (if-let (file-path (w/projectile-file-path))
      (progn
        (message file-path)
        (kill-new file-path))
    (message "WARNING: Current buffer is not visiting a file!")))

;; More key mapping
(map! :leader
      (:prefix-map ("f" . "file")
       :desc "Yank relative filename" "y"   #'w/projectile-copy-file-path
       :desc "Yank filename"          "Y"   #'+default/yank-buffer-filename
       )
      )
