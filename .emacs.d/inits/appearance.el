;; replace-colorthemes
;; git clone https://github.com/emacs-jp/replace-colorthemes.git
(bundle cycle-themes
  :features cycle-themes
  ;; 使うthemeを設定する
  (setq cycle-themes-theme-list
        '(adwaita deeper-blue shaman julie))
  ;; 切り替えたときのthemeを表示する
  (defun cycle-themes-after-cycle-hook--show ()
    (message "Themes = %S" custom-enabled-themes))
  (add-hook 'cycle-themes-after-cycle-hook 'cycle-themes-after-cycle-hook--show)
  ;; [2015-04-28 Tue]これがないとエラーになる…
  (setq custom-known-themes (append '(user changed) cycle-themes-theme-list))
  (cycle-themes-mode 1))
(eval-after-load 'cycle-themes
'(progn
   ;; C-c tで切り替える
   (define-key cycle-themes-mode-map (kbd "C-c C-t") nil)
   (define-key cycle-themes-mode-map (kbd "C-c t") 'cycle-themes)))
;; (add-to-list 'custom-theme-load-path
;;   (file-name-as-directory "~/.emacs.d/replace-colorthemes"))
;; (load-theme 'shaman t t)
;; (enable-theme 'shaman)
(bundle fill-column-indicator
  :features fill-column-indicator)
(bundle highlight-indentation
  :features highlight-indentation
  (setq highlight-indentation-offset 4)
  (set-face-background 'highlight-indentation-face "#e3e3d3")
  (set-face-background 'highlight-indentation-current-column-face
                       "#e3e3d3")
  (add-hook 'python-mode-hook 'highlight-indentation-current-column-mode))
(bundle highlight-symbol
  :features highlight-symbol
  (global-set-key [(control f3)] 'highlight-symbol-at-point)
  (global-set-key [f3] 'highlight-symbol-next)
  (global-set-key [(shift f3)] 'highlight-symbol-prev)
  (global-set-key [(meta f3)] 'highlight-symbol-query-replace))
;;;transparent emacs
(set-frame-parameter (selected-frame) 'alpha '(85 50))
(add-to-list 'default-frame-alist '(alpha 75 50))
(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
       100)
      (set-frame-parameter nil 'alpha '(90 100))
    (set-frame-parameter nil 'alpha '(15 25))))
(global-set-key [f6] 'toggle-transparency)
;;;color the current line
(global-hl-line-mode t)
(set-face-background 'hl-line "SlateBlue4")
;;;maximize frame
(set-frame-parameter nil 'fullscreen 'maximized)

;; scroll bar
(bundle yascroll
  :features yascroll
  (global-yascroll-bar-mode t))
;; show line numbers
(when (require 'linum nil t)
  (global-set-key (kbd "M-n") #'linum-mode)
  (set-face-attribute 'linum nil :foreground "aquamarine4"))

;; fold-dwim for hide-show to be toggled
;;(folding.el, outline.el, TeX-fold.el, and nxml-outln.el supported)
(bundle fold-dwim
  :features fold-dwim
  (add-hook 'c-mode-common-hook 'hs-minor-mode)
  (add-hook 'python-mode-hook 'hs-minor-mode))
(eval-after-load 'fold-dwim
  '(progn
     (define-key global-map (kbd "C-;") 'fold-dwim-toggle)))

;; visualize whitespace
;; (require 'whitespace)
;; (setq whitespace-style '(face ; faceで可視化
;;               trailing        ; 行末
;;               tab             ; タブ
;;               spaces          ; スペース
;;               empty           ; 先頭/末尾の空行
;;               space-mark      ; 表示のマッピング
;;               tab-mark))

;; ;; 保存前に自動でクリーンアップ
;; (setq whitespace-action '(auto-cleanup))
;; (global-whitespace-mode 1)

;; (defvar my/bg-color "#232323")
;; (set-face-attribute 'whitespace-trailing nil
;;                     :background my/bg-color
;;                     :foreground "DeepPink"
;;                     :underline t)
;; (set-face-attribute 'whitespace-tab nil
;;                     :background my/bg-color
;;                     :foreground "LightSkyBlue"
;;                     :underline t)
;; (set-face-attribute 'whitespace-space nil
;;                     :background my/bg-color
;;                     :foreground "GreenYellow"
;;                     :weight 'bold)
;; (set-face-attribute 'whitespace-empty nil
;;                     :background my/bg-color)
(eval-after-load 'whitespace
  '(progn
     (setq whitespace-global-modes '(not)
	   whitespace-style '(face
			      tabs
			      tab-mark
			      fw-space-mark
			      lines-tail
			      trailing
			      empty))
     ;; tab
     (setcar (nthcdr 2 (assq 'tab-mark whitespace-display-mappings)) [?> ?\t])
     (let ((face 'whitespace-tab))
       (set-face-background face nil)
       (set-face-attribute face nil :foreground "gray30" :strike-through t))
     ;; full-width space
     (defface full-width-space
       '((((class color) (background light)) (:foreground "azure3"))
	 (((class color) (background dark)) (:foreground "pink4")))
       "Face for full-width space"
       :group 'whitespace)
     (let ((fw-space-mark (make-glyph-code #x25a1 'full-width-space)))
       (add-to-list 'whitespace-display-mappings
		    `(fw-space-mark ? ,(vector fw-space-mark))))
     (setq whitespace-display-mappings
	   '((space-mark ?\u3000 [?\u25a1])
	     ;; WARNING: the mapping below has a problem.
	     ;; When a TAB occupies exactly one column, it will display the
	     ;; character ?\xBB at that column followed by a TAB which goes to
	     ;; the next TAB column.
	     ;; If this is a problem for you, please, comment the line below.
	     (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
     ;; スペースは全角のみを可視化
     (setq whitespace-space-regexp "\\(\u3000+\\)")
))
;; patch
;; (defsubst whitespace-char-or-glyph-code-valid-p (char)
;;   (let ((char (if (consp char) (car char) char)))
;;     (or (< char 256) (characterp char))))
;; (defadvice whitespace-display-vector-p (around improved-version activate)
;;   (let ((i (length vec)))
;;     (when (> i 0)
;;       (while (and (>= (setq i (1- i)) 0)
;;                   (whitespace-char-or-glyph-code-valid-p (aref vec i))))
;;       (setq ad-return-value (< i 0)))))

;; 保存前に自動でクリーンアップ
(setq whitespace-action '(auto-cleanup))
;; activate
(global-whitespace-mode)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)
(add-hook 'comint-mode-hook #'(lambda() (setq show-trailing-whitespace nil)))
;; 自動クリーンアップ無効化
(add-hook 'markdown-mode-hook
          '(lambda ()
             (set (make-local-variable 'whitespace-action) nil)))
