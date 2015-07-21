;; fold-dwim for hide-show to be toggled
;;(folding.el, outline.el, TeX-fold.el, and nxml-outln.el supported)
(require 'fold-dwim)
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)
(eval-after-load 'fold-dwim
  '(progn
     (define-key global-map (kbd "C-:") 'fold-dwim-toggle)))

(require 'fill-column-indicator)
(require 'highlight-indentation)
(setq highlight-indentation-offset 4)
(set-face-background 'highlight-indentation-face "#e3e3d3")
(set-face-background 'highlight-indentation-current-column-face
                     "#e3e3d3")
(add-hook 'python-mode-hook 'highlight-indentation-current-column-mode)
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
(global-hl-line-mode t)
(set-face-background 'hl-line "SlateBlue4")
;;高速化
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))
;; (cancel-timer global-hl-line-timer)
