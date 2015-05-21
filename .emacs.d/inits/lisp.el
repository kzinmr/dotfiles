(require 'bundle)
;;;式の評価結果を注釈するための設定
(bundle! lispxmp)
(eval-after-load 'lispxmp
  '(progn
     (define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)))
;;;括弧の対応を保持して編集する設定
(bundle! paredit
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'ielm-mode-hook 'enable-paredit-mode)
  (add-hook 'clojure-mode-hook 'paredit-mode)
  (add-hook 'nrepl-mode-hook 'paredit-mode))
(bundle rainbow-delimiters
  :features (rainbow-delimiters cl-lib color)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30)))
  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode))
(bundle! rainbow-mode)

;; -----------------------------------------------------------
;;;Gauche
;;日本語
(modify-coding-system-alist 'process "gosh" '(utf-8 . utf-8))
;;処理系をgoshに, cmuscheme.el
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
(defun scheme-other-window ()
 "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))
;; (define-key global-map
;;   "\C-cs" 'scheme-other-window)
;C-cs is occupied by yasnippet

;;Clojure
;;clojurer-mode.el, paredit.el, nrepl.el, rainbow-delimiters.el
;;http://matstani.github.io/blog/2013/04/19/clojure-dev-env-emacs/
(bundle clojure-mode)
(bundle! cider
  (add-hook 'clojure-mode-hook 'cider-mode)
  ;; mini bufferに関数の引数を表示させる
  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  ;; 'C-x b' した時に *nrepl-connection* と *nrepl-server* のbufferを一覧に表示しない
  (setq nrepl-hide-special-buffers t)
  ;; RELPのbuffer名を 'project名:nREPLのport番号' と表示する
  ;; project名は project.clj で defproject した名前
  (setq nrepl-buffer-name-show-port t))
(bundle ac-cider
  (autoload 'ac-cider "ac-cider" nil t)
  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
  (add-hook 'cider-mode-hook 'ac-cider-setup)
  (add-hook 'cider-repl-mode-hook 'ac-cider-setup))
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))
(bundle slamhound)
