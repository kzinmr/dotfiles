; YaTeX with TeX Live 2013
;; https://github.com/emacsmirror/yatex
;; C-c t j (platex)
;; C-c t p (xdvi)
;; C-c t d (pdflatex)
;;more command in info file(M-x info m yatex)
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq load-path (cons (expand-file-name "~/.emacs.d/elisp/yatex") load-path))
(require 'yatex)
;(add-to-load-path "elisp/yatex")
;(add-to-list 'load-path (concat user-emacs-directory "elisp/yatex"))
(setq section-name "section"
      YaTeX-no-begend-shortcut t ;Begin ショートカットの禁止(いきなり補完入力)
      YaTeX-create-file-prefix-g t ;[prefix] g で相手のファイルがなかったら新規作成
;      YaTeX-template-file (expand-file-name "~/Dropbox/work/tex/template/template.tex") ;新規ファイル作成時に自動挿入されるファイル名
)

;; set anto newlining off
(add-hook 'yatex-mode-hook
'(lambda () (auto-fill-mode -1)))

;;for skk
(add-hook 'skk-mode-hook
  (lambda () (if (eq major-mode 'yatex-mode)
		 (progn
		   (define-key skk-j-mode-map "\\" 'self-insert-command)
		   (define-key skk-j-mode-map "$" 'YaTeX-insert-dollar)))))

;;http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?YaTeX
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-kanji-code nil) ;(1 JIS, 2 SJIS, 3 EUC, 4 UTF-8)
(setq YaTeX-use-LaTeX2e t)
(setq YaTeX-use-AMS-LaTeX t)
(setq YaTeX-dvi2-command-ext-alist
      '(("texworks\\|evince\\|okular\\|zathura\\|qpdfview\\|pdfviewer\\|mupdf\\|xpdf\\|firefox\\|chromium\\|acroread\\|pdfopen" . ".pdf")))
(setq tex-command "ptex2pdf -l -ot '-synctex=1'")
(setq bibtex-command (cond ((string-match "uplatex\\|-u" tex-command) "upbibtex")
                           ((string-match "platex" tex-command) "pbibtex")
                           ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "bibtexu")
                           ((string-match "pdflatex\\|latex" tex-command) "bibtex")
                           (t "pbibtex")))
(setq makeindex-command (cond ((string-match "uplatex\\|-u" tex-command) "mendex")
                              ((string-match "platex" tex-command) "mendex")
                              ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "texindy")
                              ((string-match "pdflatex\\|latex" tex-command) "makeindex")
                              (t "mendex")))
(setq dviprint-command-format "acroread `echo %s | sed -e \"s/\\.[^.]*$/\\.pdf/\"`")

; RefTeX with YaTeX
;; (add-hook 'yatex-mode-hook 'turn-on-reftex)
(add-hook 'yatex-mode-hook
          '(lambda ()
             (reftex-mode 1)
             (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
             (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))

;; -----------------------------------------------------------
;;数式モードの";"補間の強化
;; "$"で囲まれていたり，数式環境内 (equation とか) で有効
;;";" を使って数学記号の補完,":" だと ギリシャ文字を補完
(setq YaTeX-math-sign-alist-private
      '(("q"   "quad"  "__") ;spacing
	("qq"  "qquad"  "____") ;spacing
	("il"  "varinjlim"  "lim\n-->")
	("pl"  "varprojlim"  "lim\n<--") ;
	("li"  "varliminf"  "lim\n---")
	("ls"  "varlimsup"  "___\nlim")
	("st"  "text{ s.~t. }"  "s.t.")
	("bigop"  "bigoplus"  "_\n(+)~") ;直和
	("bigot"  "bigotimes"  "_\n(x)\n ~") ;直積
	("le"  "Leftrightarrow"  "<=>")
	))
;;数式モードの","補間
(setq YaTeX-math-funcs-list
      '(("s"  "sin"  "sin")
	("c"  "cos"  "cos")
	("t"  "tan"  "tan")
	("hs"  "sinh"  "sinh")
	("hc"  "cosh"  "cosh")
	("ht"  "tanh"  "tanh")
	("S"  "arcsin"  "arcsin")
	("C"  "arccos"  "arccos")
	("T"  "arctan"  "arctan")
;	("se"  "sec"  "sec")
;	("cs"  "csc"  "csc")
;	("cot"  "cot"  "cot")
	("l"  "ln"  "ln")
	("L"  "log"  "log")
	("e"  "exp"  "exp")
	("M"  "max"  "max")
	("m"  "min"  "min")
	("su"  "sup"  "sup")
	("in"  "inf"  "inf")
	("di"  "dim"  "dim")
	("de"  "det"  "det")
	("i"  "imath"  "i")
	("j"  "jmath"  "j")
	("I"  "Im"  "Im")
	("R"  "Re"  "Re")
	))
(setq YaTeX-math-key-list-private
      '(("," . YaTeX-math-funcs-list)
	))
;; -----------------------------------------------------------
