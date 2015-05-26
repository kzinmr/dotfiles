;;;micellenious settings--------------------------------------
;;keybinds
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-j" 'newline-and-indent)
;(global-set-key "\C-x\C-b" 'list-buffers)
(global-set-key "\M-g" 'goto-line)
(defun line-to-top-of-window () (interactive) (recenter 0))
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p) (split-window-horizontally))
  (other-window 1))
(global-set-key "\C-o" 'comment-or-uncomment-region)
(global-set-key "\C-t" 'other-window)
(global-set-key "\C-c\C-u" 'dired-jump)
(global-set-key "\C-c\C-d" 'delete-region)
(global-set-key "\C-c\C-h" 'help-command)
(global-set-key "\C-c\C-v" 'describe-variable)
;; -----------------------------------------------------------
(bundle! sequential-command
  (define-sequential-command seq-home
    beginning-of-line beginning-of-buffer seq-return)
  (define-sequential-command seq-end
    end-of-line end-of-buffer seq-return)
  (global-set-key "\C-a" 'seq-home)
  (global-set-key "\C-e" 'seq-end))
;; (bundle mwim
;;   (global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
;;   (global-set-key (kbd "C-e") 'mwim-end-of-code-or-line))
