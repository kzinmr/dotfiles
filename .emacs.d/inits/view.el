;; fold-dwim for hide-show to be toggled
;;(folding.el, outline.el, TeX-fold.el, and nxml-outln.el supported)
(bundle! fold-dwim
  (add-hook 'c-mode-common-hook 'hs-minor-mode)
  (add-hook 'python-mode-hook 'hs-minor-mode))
(eval-after-load 'fold-dwim
  '(progn
     (define-key global-map (kbd "C-:") 'fold-dwim-toggle)))

; highlight specified symbols
(bundle! fill-column-indicator)
(bundle! highlight-indentation
  (setq highlight-indentation-offset 4)
  (set-face-background 'highlight-indentation-face "#e3e3d3")
  (set-face-background 'highlight-indentation-current-column-face
                       "#e3e3d3")
  (add-hook 'python-mode-hook 'highlight-indentation-current-column-mode))
(bundle! highlight-symbol
  (global-set-key [(control f3)] 'highlight-symbol-at-point)
  (global-set-key [f3] 'highlight-symbol-next)
  (global-set-key [(shift f3)] 'highlight-symbol-prev)
  (global-set-key [(meta f3)] 'highlight-symbol-query-replace))
