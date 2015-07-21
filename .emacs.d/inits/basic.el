;; shell
(setq-default explicit-shell-file-name "zsh")
(setq shell-file-name "zsh"
      shell-command-switch "-c")
(add-hook 'sh-mode-hook
          (lambda ()
            (if (string-match "\\.zsh$" buffer-file-name)
                (sh-set-shell "zsh"))))

;;;yes is y
(fset 'yes-or-no-p 'y-or-n-p)

(defalias 'message-box 'message)

;;tab
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)
;;font
(set-face-attribute 'default nil :height 160)
