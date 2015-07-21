; replace-colorthemes
;; git clone https://github.com/emacs-jp/replace-colorthemes.git
;; (bundle! cycle-themes
;;   ;; 使うthemeを設定する
;;   (setq cycle-themes-theme-list
;;         '(deeper-blue adwaita shaman julie))
;;   ;; 切り替えたときのthemeを表示する
;;   (defun cycle-themes-after-cycle-hook--show ()
;;     (message "Themes = %S" custom-enabled-themes))
;;   (add-hook 'cycle-themes-after-cycle-hook 'cycle-themes-after-cycle-hook--show)
;;   ;; [2015-04-28 Tue]これがないとエラーになる…
;;   (setq custom-known-themes (append '(user changed) cycle-themes-theme-list))
;;   (cycle-themes-mode 1))
;; (eval-after-load 'cycle-themes
;; '(progn
;;    ;; C-c tで切り替える
;;    (define-key cycle-themes-mode-map (kbd "C-c C-t") nil)
;;    (define-key cycle-themes-mode-map (kbd "C-c t") 'cycle-themes)))

;; scroll bar
(require 'yascroll)
(global-yascroll-bar-mode t);)
;; show line numbers
(when (require 'linum nil t)
  (global-set-key (kbd "M-n") #'linum-mode)
  (set-face-attribute 'linum nil :foreground "aquamarine4"))

; visualize whitespace
(eval-after-load 'whitespace
  '(progn
     (setq whitespace-global-modes '(not) whitespace-style
           '(face
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
(defsubst whitespace-char-or-glyph-code-valid-p (char)
  (let ((char (if (consp char) (car char) char)))
    (or (< char 256) (characterp char))))
(defadvice whitespace-display-vector-p (around improved-version activate)
  (let ((i (length vec)))
    (when (> i 0)
      (while (and (>= (setq i (1- i)) 0)
                  (whitespace-char-or-glyph-code-valid-p (aref vec i))))
      (setq ad-return-value (< i 0)))))
;; clean up automatically
(setq whitespace-action '(auto-cleanup))
;; activate
(global-whitespace-mode)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)
(add-hook 'comint-mode-hook #'(lambda() (setq show-trailing-whitespace nil)))
;; disable auto clean-up
(add-hook 'markdown-mode-hook
          '(lambda ()
             (set (make-local-variable 'whitespace-action) nil)))
(add-hook 'elpy-mode-hook
          '(lambda ()
             (set (make-local-variable 'whitespace-action) nil)))
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
