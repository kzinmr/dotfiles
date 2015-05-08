;; shell
(setq-default explicit-shell-file-name "zsh")
(setq shell-file-name "zsh"
      shell-command-switch "-c")

;;;yes is y
(fset 'yes-or-no-p 'y-or-n-p)

(defalias 'message-box 'message)
