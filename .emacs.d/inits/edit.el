; show recent used files
(bundle! recentf-ext
  (setq recentf-max-saved-items 1000)
  (setq recentf-exclude '("/TAGS$" "/var/tmp/"))
  (global-set-key "\C-z" 'recentf-open-files))

; open junk file for trial
(bundle! open-junk-file
  (global-set-key (kbd "C-x C-z") 'open-junk-file))

; dired
(setq dired-recursive-copies 'alway)
(setq dired-recursive-deletes 'always)
;; wdired
;;same as replace-regexp, query-replace
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")))

; undo/redo's
(bundle! undo-tree
  (global-undo-tree-mode))
(bundle! redo+
  (global-set-key (kbd "C-M-/") 'redo)
  (setq undo-no-redo t)
  (setq undo-limit 600000)
  (setq undo-strong-limit 900000))
(bundle! point-undo
  (define-key global-map [f7] 'point-undo)
  (define-key global-map [S-f7] 'point-redo))

; just goto recently changed points
(bundle! goto-chg
  (global-set-key [f8] 'goto-last-change)
  (global-set-key [S-f8] 'goto-last-change-reverse))

; cua-mode
;;C-Enter(rectangle region)
;(global-set-key (kbd "C-x SPC") 'cua-rectangle-mark-mode)
;(cua-mode t)
;(setq cua-enable-cua-keys nil)


; ddskk
;;dict: http://openlab.jp/skk/wiki/wiki.cgi?page=SKK%BC%AD%BD%F1
;;辞書などの諸設定は skk-init-file(~/.skk) で定義
;; (bundle skk-dev/ddskk
;;   :features (skk skk-study)
;;   (global-set-key (kbd "C-x j") 'skk-mode)
;;   (setq default-input-method "japanese-skk"))
(global-set-key (kbd "C-x j") 'skk-mode)
(setq default-input-method "japanese-skk")
;; 「、。」「，．」toggle by f5
(defun toggle-skk-kutouten-type nil
  (interactive)
  (cond
   ((equal skk-kutouten-type 'en)
    (setq-default skk-kutouten-type 'jp))
   ((equal skk-kutouten-type 'jp)
    (setq-default skk-kutouten-type 'en))
   ((t nil))))
(global-set-key (kbd "<f5>") 'toggle-skk-kutouten-type)
