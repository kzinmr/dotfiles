(bundle ess
  :features (ess-site ess-eldoc)
  (add-hook 'inferior-ess-mode-hook 'ess-use-eldoc))
  ;; C-M-a ess-beginning-of-function
  ;; C-M-e ess-end-of-function
  ;; C-M-h ess-mark-function
  ;; C-c C-v start *R*
