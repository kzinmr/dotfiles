(bundle! auto-async-byte-compile
  ;;自動バイトコンパイルを無効にするファイル名の正規表現
  (setq auto-async-byte-compile-exclude-files-regexp "/junk/")
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
  (setq eldoc-idle-delay 0.2) ;すぐに表示したい
  (setq eldoc-minor-mode-string "") ;モードラインにElDocと表示しない
  ;; find-functionをキー割り当てする
  (find-function-setup-keys))

;;apt-get install global
(bundle! ggtags
  ;;M-x imenu(jump to function)
  ;;M-.
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p
                     'c-mode 'c++-mode 'java-mode)
                (ggtags-mode 1)))))

;; -----------------------------------------------------------
;; pair input
(defun insert-bracket-pair (leftBracket rightBracket)
  (if (region-active-p)
      (let ((p1 (region-beginning))
	    (p2 (region-end)))
	(goto-char p2)
	(insert rightBracket)
	(goto-char p1)
	(insert leftBracket)
	(goto-char (+ p2 2)))
    (progn
      (insert leftBracket rightBracket)
      (backward-char 1))))
(defun insert-pair-brace () (interactive) (insert-bracket-pair "{" "}") )
(defun insert-pair-paren () (interactive) (insert-bracket-pair "(" ")") )
(defun insert-pair-double-straight-quote () (interactive) (insert-bracket-pair "\"" "\"") )
(defun insert-pair-single-straight-quote () (interactive) (insert-bracket-pair "'" "'") )
(defun insert-pair-bracket () (interactive) (insert-bracket-pair "[" "]") )
(defun insert-pair-angle-bracket () (interactive) (insert-bracket-pair "<" ">") )
(define-key global-map "{" 'insert-pair-brace)
(define-key global-map "(" 'insert-pair-paren)
(define-key global-map "\"" 'insert-pair-double-straight-quote)
(define-key global-map "'" 'insert-pair-single-straight-quote)
(define-key global-map "[" 'insert-pair-bracket)
(define-key global-map "<" 'insert-pair-angle-bracket)
;; -----------------------------------------------------------
;;M-x which-function-mode
;;always show current func name

(which-function-mode 1)
;To show the function in the HeaderLine instead of the ModeLine
(setq mode-line-format
      (delete (assoc 'which-func-mode
		     mode-line-format) mode-line-format)
      which-func-header-line-format
      '(which-func-mode ("" which-func-format)))

;; git-gutter(use *-fringe to work with linum-mode)
(bundle! git-gutter-fringe
  (global-git-gutter-mode t))

;; flycheck
(bundle flycheck
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; eldoc
(setq-default eldoc-idle-delay 0.1
              eldoc-echo-area-use-multiline-p t
              flycheck-display-errors-delay 0.2)
(dolist (hook '(emacs-lisp-mode-hook
                lisp-interaction-mode-hook
                ielm-mode-hook))
  (add-hook hook #'turn-on-eldoc-mode))
(bundle c-eldoc
  (dolist (hook '(c-mode-hook c++-mode-hook))
    (add-hook hook #'(lambda ()
                       (set (make-local-variable 'eldoc-idle-delay) 0.3)
                       (c-turn-on-eldoc-mode)))))
(bundle eldoc-extension)

;; C-;でカーソル位置の (またはリージョン指定した) シンボルを対象として同時編集モードに入る。
;; M-hでマッチする範囲をカーソル位置の関数に限定。
;; M-iでマッチする範囲をカーソル位置の行に限定。M-n,M-pで領域を上下に1行ずつ増やす。
;; TAB,Shift-TABでマッチした箇所を巡回。巡回中にC-mで現在位置のマッチを解除。
;; C-;で同時編集モード終了。
(bundle! victorhge/iedit
  (define-key global-map (kbd "C-c ;") 'iedit-mode))
(define-key iedit-mode-keymap (kbd "C-m") 'iedit-toggle-selection)
(define-key iedit-mode-keymap (kbd "M-p") 'iedit-expand-up-a-line)
(define-key iedit-mode-keymap (kbd "M-n") 'iedit-expand-down-a-line)
(define-key iedit-mode-keymap (kbd "M-h") 'iedit-restrict-function)
(define-key iedit-mode-keymap (kbd "M-i") 'iedit-restrict-current-line)
(define-key iedit-mode-keymap (kbd "C-h") 'delete-backward-char)

;; magit(http://magit.vc/)
;; M-x magit-status(git status); TAB(diff); s(add); c(commit); P(push)
(bundle! magit)
