; Python
(setenv "PYTHONPATH" "/usr/bin/python")
(add-hook 'python-mode-hook
                   '(lambda ()
                        (setq indent-tabs-mode nil)
                        (setq indent-level 4)
                        (setq python-indent 4)
                        (setq tab-width 4)))
(define-key global-map
  "\C-cp" 'run-python)
(defun my-short-buffer-file-coding-system (&optional default-coding)
  (let ((coding-str (format "%S" buffer-file-coding-system)))
    (cond ((string-match "shift-jis" coding-str) 'shift_jis)
          ((string-match "euc-jp" coding-str) 'euc-jp)
          ((string-match "utf-8" coding-str) 'utf-8)
          (t (or default-coding 'utf-8)))))
(defun my-insert-file-local-coding ()
  "ファイルの先頭に `coding:' を自動挿入する"
  (interactive)
  (save-excursion
    (goto-line 2) (end-of-line)
    (let ((limit (point)))
      (goto-char (point-min))
      (unless (search-forward "coding:" limit t) ; 2行目以内に `coding:'がない
        (goto-char (point-min))
        ;; #!で始まる場合２行目に記述
        (when (and (< (+ 2 (point-min)) (point-max))
                   (string= (buffer-substring (point-min) (+ 2 (point-min))) "#!"))
          (unless (search-forward "\n" nil t) ; `#!'で始まり末尾に改行が無い場合
            (insert "\n")))                   ; 改行を挿入
        (let ((st (point)))
          (insert (format "-*- coding: %S -*-\n" (my-short-buffer-file-coding-system)))
          (comment-region st (point)))))))
(add-hook 'python-mode-hook 'my-insert-file-local-coding)

;pip install autopep8
(bundle! 'py-autopep8
  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save))

; Elpy.el
;;pip install --user rope jedi flake8 (importmagic)
;;Elpy does not use Pymacs, Ropemacs and Ropemode anymore,
;;but instead provides its own Python interface with the elpy package on PyPI.
; Inline code completion (company-mode)
; Show function signatures (ElDoc)
; Syntax Error Highlighting and PEP8 Highlighting (Flymake)
; Display indentation markers (highlight-indentation)
; Show the virtualenv in the mode line (pyvenv)
; Expand code snippets (YASnippet)
; Auto-complete is brought in by jedi and rope.
; Simultaneous Editing is brought in by iedit.el.
; Code block shifting: C-c > or C-c <
; Automatic import is brought in by importmagic (disabled dueto error)
(bundle! elpy
  (elpy-enable))
;; Fixing a key binding bug in elpy
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;; Fixing another key binding bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)
;; use flycheck insteadof flymake
(when (require 'flycheck nil t)
  (remove-hook 'elpy-modules 'elpy-module-flymake))

;; Another python mode options:
;; https://github.com/python-rope/ropemacs
;; https://github.com/proofit404/anaconda-mode
