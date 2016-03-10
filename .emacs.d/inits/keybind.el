; keybinds
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-j" 'newline-and-indent)
;(global-set-key "\C-x\C-b" 'list-buffers)
(global-set-key "\M-g" 'goto-line)
(defun line-to-top-of-window () (interactive) (recenter 0))
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p) (split-window-horizontally))
  (other-window 1))
(global-set-key "\C-t" 'other-window)
(global-set-key "\C-c\C-u" 'dired-jump)
(global-set-key "\C-c\C-d" 'delete-region)
(global-set-key "\C-c\C-h" 'help-command)
(global-set-key "\C-cv" 'describe-variable)
(global-set-key "\C-cf" 'describe-function)
(global-set-key "\C-l" 'recenter-top-bottom)

(bundle! sequential-command
  (define-sequential-command seq-home
    beginning-of-line beginning-of-buffer seq-return)
  (define-sequential-command seq-end
    end-of-line end-of-buffer seq-return)
  (global-set-key "\C-a" 'seq-home)
  (global-set-key "\C-e" 'seq-end)
  (require 'sequential-command-config)
  (when (require 'org nil t)
    (define-key org-mode-map "\C-a" 'org-seq-home)
    (define-key org-mode-map "\C-e" 'org-seq-end))
  (define-key esc-map "u" 'seq-upcase-backward-word)
  (define-key esc-map "c" 'seq-capitalize-backward-word)
  (define-key esc-map "l" 'seq-downcase-backward-word))
;; (bundle mwim
;;   (global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
;;   (global-set-key (kbd "C-e") 'mwim-end-of-code-or-line))

;; M-; (comment-dwim with transient-mark-mode )が有効なので不要
;;(global-set-key "\C-o" 'comment-or-uncomment-region)
(bundle! comment-dwim-2
  (global-set-key (kbd "M-;") 'comment-dwim-2)
  (setq comment-dwim-2--inline-comment-behavior 'reindent-comment)
  ;; ;;; 現在行のコメントをkillする(デフォルト)
  ;; (setq comment-dwim-2--inline-comment-behavior 'kill-comment)
  )
