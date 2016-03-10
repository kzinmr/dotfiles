; org-mode
;;M-x org-insert-heading-dwim
;;C-RET, C-u C-RET, C-u C-u C-RET
;;alernative: ChangeLog(C-u C-x 4 a), hown(http://howm.sourceforge.jp/index-j.html), Planner(http://download.gna.org/planner-el)
;;; Code:
(bundle org
  :features (org org-install ob)
  ;; 見出しの余分な*を消す
  (setq org-hide-leading-stars t)
  ;; 画面端で改行する
  (setq org-startup-truncated nil)
  ;; 見出しを畳まない
  (setq org-startup-folded nil)
  ;; returnでリンクを飛ぶ
  (setq org-return-follows-link t)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (setq org-directory "~/Dropbox/org/")
  ;; 時刻の記録をagendaに表示させる
  (setq org-agenda-start-with-log-mode t)
  ;; inbox.orgのサンプルにあわせ、今日から30日分の予定を表示させる
  (setq org-agenda-span 30)
  ;; org-agendaで扱うorgファイルたち
  ;; use agenda
  (setq org-agenda-files (list org-directory))
  (setq org-default-notes-file (concat org-directory "inbox.org"))
  ;; org-remember -> org-capture from org-mode 8.2.10
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline nil "Inbox")
           "** TODO %?\n   %i\n   %a\n   %t")
          ("b" "Bug" entry
           (file+headline nil "Inbox")
           "** TODO %?   :bug:\n   %i\n   %a\n   %t")
          ;; ("p" "Progress" entry
          ;;  (file+headline nil "Inbox")
          ;;  "** %?\n   :progress:\n   %i\n   %a\n   %t")
          ("i" "Idea" entry
           (file+headline nil "New Ideas")
           "** %?\n   %i\n   %a\n   %t")
          ("m" "Memo" entry
           (file+headline nil "Memos")
           "** %?\n   %T")))
  ;; agendaには、習慣・スケジュール・TODOを表示させる
  ;; (setq org-agenda-custom-commands
  ;;     '(("a" "Agenda and all TODO's"
  ;;        ((tags "progress") (agenda "") (alltodo)))))

  (setq org-agenda-custom-commands
      '(("a" "Agenda and all TODO's"
         ((tags "wiki") (tags "progress-CLOCK=>\"<today>\"|repeatable") (agenda "") (alltodo)))))
  (defun org-agenda-default ()
    (interactive)
    (org-agenda nil "a"))
  (global-set-key (kbd "<f5>") 'org-agenda-default)

  ;; org-capture-memoを実行すれば画面下にメモをとるためのバッファが立ち上がる
  ;; C-cC-cでメモを保存 C-c C-kでキャンセル
  (defun org-capture-memo (n)
    (interactive "p")
    (case n
      (4 (org-capture nil "M"))
      (t (org-capture nil "m"))))

  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-cc" 'org-capture)
  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb)
  (add-hook 'org-mode-hook 'turn-on-font-lock)
  ;; 見出し移動: C-c+ C-p C-n C-f C-b -> Ctr + 上下、Ctr + Shift + 上下
  (define-key org-mode-map [(control up)] 'outline-previous-visible-heading)
  (define-key org-mode-map [(control down)] 'outline-next-visible-heading)
  (define-key org-mode-map [(control shift up)] 'outline-backward-same-level)
  (define-key org-mode-map [(control shift down)] 'outline-forward-same-level)
  ;; code-reading
  (defvar org-code-reading-software-name nil)
  ;; ~/memo/code-reading.org に記録する
  (defvar org-code-reading-file "code-reading.org")
  (defun org-code-reading-read-software-name ()
    (set (make-local-variable 'org-code-reading-software-name)
         (read-string "Code Reading Software: "
                      (or org-code-reading-software-name
                          (file-name-nondirectory
                           (buffer-file-name))))))
  (defun org-code-reading-get-prefix (lang)
    (let ((sname (org-code-reading-read-software-name))
          (fname (file-name-nondirectory
                  (buffer-file-name))))
      (concat "[" lang "]"
              "[" sname "]"
              (if (not (string= sname fname)) (concat "[" fname "]")))))
  (defun org-capture-code-reading ()
    (interactive)
    (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
           (org-capture-templates
            '(("c" "Code Reading" entry (file+headline (concat org-directory org-code-reading-file) "Code Readings") "** %(identity prefix) %?\n   %a\n   %T")
              )))
      (org-capture nil "c")))

  (defun org-insert-upheading (arg)
    "1レベル上の見出しを入力する。"
    (interactive "P")
    (org-insert-heading arg)
    (cond ((org-on-heading-p) (org-do-promote))
          ((org-at-item-p) (org-outdent-item))))
  ;; 	((org-insert-item-p) (org-insert-item -1))))
  (defun org-insert-heading-dwim (arg)
    "現在と同じレベルの見出しを入力する
     C-u を付けると 1レベル上、C-uC-u を付けると 1レベル下の見出しを入力する"
    (interactive "p")
    (case arg
      (4 (org-insert-subheading nil)) ;C-u
      (16 (org-insert-upheading nil)) ;C-u C-u
      (t (org-insert-heading nil))))
  (define-key org-mode-map (kbd "<C-return>") 'org-insert-heading-dwim)

  ;; ;; 画像をインライン表示する
  ;; (add-hook 'org-mode-hook 'turn-on-iimage-mode))

  (unless (member "CLOCK" org-special-properties)
    (defun org-get-CLOCK-property (&optional pom)
      (org-with-wide-buffer
       (org-with-point-at pom
         (when (and (derived-mode-p 'org-mode)
                    (ignore-errors (org-back-to-heading t))
                    (search-forward org-clock-string
                                    (save-excursion (outline-next-heading) (point))
                                    t))
           (skip-chars-forward " ")
           (cons "CLOCK"  (buffer-substring-no-properties (point) (point-at-eol)))))))
    (defadvice org-entry-properties (after with-CLOCK activate)
      "special-propertyにCLOCKを復活させorg習慣仕事術を最新版orgで動かす"
      (let ((it (org-get-CLOCK-property (ad-get-arg 0))))
        (setq ad-return-value
              (if it
                  (cons it ad-return-value)
                ad-return-value)))))
  )
;; -----------------------------------------------------------
;; yas/org
;; binding to [tab] instead of "\t" may overrule yasnippet
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (org-set-local 'yas/trigger-key [tab])
;;             (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))
;; if it doesn't work
(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
(add-hook 'org-mode-hook
          (lambda ()
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))

;;org-babel
;; #+BEGIN_SRC emacs-lisp
;; code
;; #+END_SRC
;; C-c ' : 編集用のバッファを各言語のモードで開く
;; C-c C-c: 実行結果
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)
   (python . t)
   (perl . t)
   ;; (R . t)
   (ditaa . t)))
(setq org-confirm-babel-evaluate nil)
(setq org-src-fontify-natively t)
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'org-display-inline-images)
;; (add-to-list 'org-babel-tangle-lang-exts '("clojure" . "clj"))
;; (defvar org-babel-default-header-args:clojure
;;   '((:results . "silent") (:tangle . "yes")))
;; (defun org-babel-execute:clojure (body params)
;;   (lisp-eval-string body)
;;   "Done!")
;; (provide 'ob-clojure)

;; need Bazaar
;; (bundle! org2blog)



(setq org-latex-classes
      '(("IEEEdouble"
         "\\documentclass[11pt,twocolumn,twoside]{IEEEtran}
\\usepackage{newenum}
\\usepackage{times,amsmath,amssymb}
\\usepackage{amsthm}
\\usepackage{cite,subfigure,bm}
\\usepackage{multicol,multirow}
\\usepackage{array}
\\usepackage[dvipdfmx,hiresbb]{graphicx}
\\usepackage[dvipdfmx]{color}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ("IEEEsingle"
         "\\documentclass[11pt,draftcls,onecolumn]{IEEEtran}
\\usepackage{newenum}
\\usepackage{times,amsmath,amssymb}
\\usepackage{amsthm}
\\usepackage{cite,subfigure,bm}
\\usepackage{multicol,multirow}
\\usepackage{array}
\\usepackage[dvipdfmx,hiresbb]{graphicx}
\\usepackage[dvipdfmx]{color}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ("thesis"
         "
        \\documentclass{jsarticle}
        \\usepackage[dvipdfmx]{graphicx}
        \\usepackage[utf8]{inputenc}
        \\usepackage[T1]{fontenc}
        "
         ("\\chapter{%s}" . "\\chapter*{%s}")
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ("report"
         "
        \\documentclass{jsarticle}
        \\usepackage[dvipdfmx]{graphicx}
        \\usepackage[utf8]{inputenc}
        \\usepackage[T1]{fontenc}
        "
         ("\\chapter{%s}" . "\\chapter*{%s}")
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ))
(setq org-latex-default-class "jsarticle")

;;; LaTeX 形式のファイル PDF に変換するためのコマンド
(setq org-latex-pdf-process
      '("platex %f"
        "bibtex %b"
        "platex %f"
        "platex %f"
        "dvipdfmx %b.dvi"))

;; shortcut command
(setq org-use-speed-commands t)

;;; init-org.el ends here
