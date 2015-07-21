; clipboard <-> kill-ring
(global-set-key [(shift delete)] 'clipboard-kill-region)
(global-set-key [(control insert)] 'clipboard-kill-ring-save)
(global-set-key [(shift insert)] 'clipboard-yank)

; auto saving buffer by 1 sec
(bundle! auto-save-buffers-enhanced
  (setq auto-save-buffers-enhanced-interval 1)
  (auto-save-buffers-enhanced t))

; bookmark & highlight lines
(bundle! bm
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

;;;keep history till next startup
(savehist-mode 1)

; memorize the cursor place in file
(when (require 'saveplace nil t)
  (setq-default save-place t)
  (setq save-place-file "~/.emacs.d/places"))

; expand the length of log
(setq message-log-max 10000)

; warn when large(25MB~) size file is opend(10MB is default)
(setq large-file-warning-threshold (* 25 1024 1024))

;;;ffap:set the default open file url to the current place
(ffap-bindings)

; improve the completion of switch-to-buffer
(iswitchb-mode 1)
(setq read-buffer-function 'iswitchb-read-buffer)
(setq iswitchb-prompt-newbuffer- nil)
;;use partial string, not regexp
;; (setq iswitchb-regexp nil)
; ido:use iswitchb completion with file-open
;(ido-mode 1)

;; Automatically reload files was modified by external program
(global-auto-revert-mode 1)

;;;save the input of minibuffer in history evenif its cancelled
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))

; uniquify(default for 24.4.<): distinguish same buffernames
;; (require 'uniquify)
;;filename<dir>
;; (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;;*filename* is excepted
;; (setq uniquify-ignore-buffers-re "*[^*]+*")

; emacsclient
;;in shell config file: export EDITOR=emacsclient
(server-start)
(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))
;;uncomment to iconify Emacs when editting is done
;; (add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
(global-set-key "\C-x\C-c" 'server-edit)
;;finish Emacs with M-x exit not C-x C-c
(defalias 'exit 'save-buffers-kill-emacs)

; swap buffers
(bundle! swap-buffers
  (defun swap-buffers-keep-focus ()
    (interactive)
    (swap-buffers t))
  ;;; like swap-screen
  (global-set-key [f2] 'swap-buffers-keep-focus)
  (global-set-key [S-f2] 'swap-buffers))

; ace-jump-mode(for multiple display)
(bundle! ace-jump-mode
  (autoload
    'ace-jump-mode
    "ace-jump-mode"
    "Emacs quick move minor mode"
    t)
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode))
;; powerful jump back function from ace-jump-mode
(eval-after-load "ace-jump-mode"
  '(progn
     (autoload
       'ace-jump-mode-pop-mark
       "ace-jump-mode"
       "Ace jump back:-)"
       t)
     (ace-jump-mode-enable-mark-sync)
     (define-key global-map (kbd "C-c C-SPC") 'ace-jump-mode-pop-mark)))
