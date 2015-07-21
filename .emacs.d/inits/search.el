; search and edit(C-cC-c to proceed to C-cC-k to cancel)
(bundle! color-moccur
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  (setq moccur-split-word t)
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$"))
(bundle! moccur-edit)

; search with regexp
(bundle! visual-regexp-steroids
  (setq vr/engine 'python)
  ;; (setq vr/engine 'pcre2el) ;elispでPCREから変換
  (global-set-key (kbd "M-%") 'vr/query-replace)
  ;; multiple-cursorsを使っているならこれで
  (global-set-key (kbd "C-c m") 'vr/mc-mark)
  ;; 普段の正規表現isearchにも使いたいならこれを
  (global-set-key (kbd "C-M-r") 'vr/isearch-backward)
  (global-set-key (kbd "C-M-s") 'vr/isearch-forward))

; replace (M-%)
(global-set-key "\C-cr" 'query-replace)
; replace with regexp (M-S-%)
(defalias 'qrr 'query-replace-regexp)

; grep(ag) + wgrep(-ag)
(bundle! wgrep
  ;; M-x grep; e
  (setf wgrep-enable-key "e")
  (setq wgrep-auto-save-buffer t)
  ;; apply changes even for read-only buffer
  (setq wgrep-change-readonly-file t))

; iedit
;; M-iでマッチする範囲をカーソル位置の行に限定。M-n,M-pで領域を上下に1行ずつ増やす。
;; TAB,Shift-TABでマッチした箇所を巡回。巡回中にC-mで現在位置のマッチを解除。
(bundle! victorhge/iedit
  (define-key global-map (kbd "C-c ;") 'iedit-mode))
(define-key iedit-mode-keymap (kbd "C-m") 'iedit-toggle-selection)
(define-key iedit-mode-keymap (kbd "M-p") 'iedit-expand-up-a-line)
(define-key iedit-mode-keymap (kbd "M-n") 'iedit-expand-down-a-line)
(define-key iedit-mode-keymap (kbd "M-h") 'iedit-restrict-function)
(define-key iedit-mode-keymap (kbd "M-i") 'iedit-restrict-current-line)
(define-key iedit-mode-keymap (kbd "C-h") 'delete-backward-char)

; cmigemo
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
