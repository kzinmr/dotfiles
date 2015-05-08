;;;buffer&file------------------------------------------------
(bundle auto-save-buffers-enhanced
  :features auto-save-buffers-enhanced
  (setq auto-save-buffers-enhanced-interval 1)
  (auto-save-buffers-enhanced t))
(bundle bm
  :features bm
  (setq-default bm-buffer-persistence nil)
  (setq bm-restore-repository-on-load t)
  (global-set-key "\M-@" 'bm-toggle)
  (global-set-key "\M-[" 'bm-previous)
  (global-set-key "\M-]" 'bm-next)
  (add-hook 'find-file-hooks 'bm-buffer-restore)
  (add-hook 'kill-buffer-hook 'bm-buffer-save)
  (add-hook 'after-save-hook 'bm-buffer-save)
  (add-hook 'after-revert-hook 'bm-buffer-restore)
  (add-hook 'vc-vefore-checkin-hook 'bm-buffer-save))
(bundle goto-chg
  :features goto-chg
  (global-set-key [f8] 'goto-last-change)
  (global-set-key [S-f8] 'goto-last-change-reverse))

;;;keep history till next startup
(savehist-mode 1)
;;;memorize the cursor place in file
(setq-default save-place t)
(require 'saveplace)
;;;expand the length of log
(setq message-log-max 10000)
;;;warning when large size file is opend(25MB over(10MB is default))
(setq large-file-warning-threshold (* 25 1024 1024))

;;; clipboard
(global-set-key [(shift delete)] 'clipboard-kill-region)
(global-set-key [(control insert)] 'clipboard-kill-ring-save)
(global-set-key [(shift insert)] 'clipboard-yank)


;;;ffap:set the default open file url to the current place
(ffap-bindings)
;;;iswitchb:improve the completion of switch-to-buffer
(iswitchb-mode 1)
(setq read-buffer-function 'iswitchb-read-buffer)
;;use partial string, not regexp
;(setq iswitchb-regexp nil)
;;dont ask when making new buffer
(setq iswitchb-prompt-newbuffer- nil)
;;;ido:use iswitchb completion with file-open
;(ido-mode 1)

;;;save the input of minibuffer in history evenif its cancelled
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))

;; -----------------------------------------------------------
;;;uniquify
(require 'uniquify)
;;filename<dir>
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;;*filename* is excepted
(setq uniquify-ignore-buffers-re "*[^*]+*")
;; -----------------------------------------------------------
;;;emacsclient:dont restart Emacs when editing files from an external program
;;emacsclient filename (external program)
;;add this setting .bashrc: export EDITOR=emacsclient
(server-start)
(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))
;;uncomment to iconify Emacs when editting is done
;;(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
(global-set-key "\C-x\C-c" 'server-edit)
;;finish Emacs with M-x exit not C-x C-c
(defalias 'exit 'save-buffers-kill-emacs)
