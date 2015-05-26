;install cmigemo?
(bundle! migemo
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  ;; Set your installed path
  (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init))
(bundle! color-moccur
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  (setq moccur-split-word t)
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$"))
(bundle! moccur-edit)
(bundle! multiple-cursors
  (defun mc/edit-lines-or-string-rectangle (s e)
    "C-x r tで同じ桁の場合にmc/edit-lines (C-u M-x mc/mark-all-dwim)"
    (interactive "r")
    (if (eq (save-excursion (goto-char s) (current-column))
            (save-excursion (goto-char e) (current-column)))
        (call-interactively 'mc/edit-lines)
      (call-interactively 'string-rectangle)))
  (global-set-key (kbd "C-x r t") 'mc/edit-lines-or-string-rectangle)
  (defun mc/mark-all-dwim-or-mark-sexp (arg)
    "C-u C-M-SPCでmc/mark-all-dwim, C-u C-u C-M-SPCでC-u M-x mc/mark-all-dwim"
    (interactive "p")
    (cl-case arg
      (16 (mc/mark-all-dwim t))
      (4 (mc/mark-all-dwim nil))
      (1 (mark-sexp 1))))
  (global-set-key (kbd "C-M-SPC") 'mc/mark-all-dwim-or-mark-sexp))

;; fold-dwim for hide-show to be toggled
;;(folding.el, outline.el, TeX-fold.el, and nxml-outln.el supported)
(bundle! fold-dwim
  (add-hook 'c-mode-common-hook 'hs-minor-mode)
  (add-hook 'python-mode-hook 'hs-minor-mode))
(eval-after-load 'fold-dwim
  '(progn
     (define-key global-map (kbd "C-:") 'fold-dwim-toggle)))


(bundle! open-junk-file
;;;試行錯誤用ファイルを開くための設定
  (global-set-key (kbd "C-x C-z") 'open-junk-file))

(bundle! point-undo
  (define-key global-map [f7] 'point-undo)
  (define-key global-map [S-f7] 'point-redo))

(bundle! recentf-ext
  (setq recentf-max-saved-items 1000)
  (setq recentf-exclude '("/TAGS$" "/var/tmp/"))
  (global-set-key "\C-z" 'recentf-open-files))

(bundle! redo+
  (global-set-key (kbd "C-M-/") 'redo)
  (setq undo-no-redo t)
  (setq undo-limit 600000)
  (setq undo-strong-limit 900000))

(bundle! undo-tree
  (global-undo-tree-mode))

(bundle! visual-regexp-steroids
  (setq vr/engine 'python)
  ;; (setq vr/engine 'pcre2el) ;elispでPCREから変換
  (global-set-key (kbd "M-%") 'vr/query-replace)
  ;; multiple-cursorsを使っているならこれで
  (global-set-key (kbd "C-c m") 'vr/mc-mark)
  ;; 普段の正規表現isearchにも使いたいならこれを
  (global-set-key (kbd "C-M-r") 'vr/isearch-backward)
  (global-set-key (kbd "C-M-s") 'vr/isearch-forward))
;; -----------------------------------------------------------
;;;dired
(setq dired-recursive-copies 'alway)
(setq dired-recursive-deletes 'always)
;;;wdired
;;cf. replace-regexp, query-replace
;; rキーでwdiredモードに入る
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")))
;; search&replace---------------------------------------------
;;M-%
(global-set-key "\C-cr" 'query-replace)
;;M-S-%
(defalias 'qrr 'query-replace-regexp)
;; input support----------------------------------------------
;;;cua-mode
;;C-Enter(rectangle region)
;(global-set-key (kbd "C-x SPC") 'cua-rectangle-mark-mode)
;(cua-mode t)
;(setq cua-enable-cua-keys nil)
;; -----------------------------------------------------------
;;;M-x kmacro-save
(defvar kmacro-save-file "~/.emacs.d/init.el")
(defun kmacro-save (symbol)
  (interactive "SName for last kbd macro: ")
  (name-last-kbd-macro symbol)
  (with-current-buffer (find-file-noselect kmacro-save-file)
    (goto-char (point-max)) ;goto the end of .emacs
    (insert-kbd-macro symbol)
    (basic-save-buffer)))
;; -----------------------------------------------------------
;;ddskk
;;dictionary: http://openlab.jp/skk/wiki/wiki.cgi?page=SKK%BC%AD%BD%F1
;;辞書などの諸設定は skk-init-file(~/.skk) で定義
;; (bundle skk-dev/ddskk
;;   :features (skk skk-study)
;;   (global-set-key (kbd "C-x j") 'skk-mode)
;;   (setq default-input-method "japanese-skk"))
;; ;; 句読点を「、。」と「，．」で toggle
  (global-set-key (kbd "C-x j") 'skk-mode)
  (setq default-input-method "japanese-skk")

(defun toggle-skk-kutouten-type nil
  (interactive)
  (cond
   ((equal skk-kutouten-type 'en)
    (setq-default skk-kutouten-type 'jp))
   ((equal skk-kutouten-type 'jp)
    (setq-default skk-kutouten-type 'en))
   ((t nil))))
(global-set-key (kbd "<f5>") 'toggle-skk-kutouten-type)
