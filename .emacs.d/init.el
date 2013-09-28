;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil -*-
;; -----------------------------------------------------------
;; @see http://github.com/elim/dotemacs/blob/master/init.el
;;
(defvar oldemacs-p (<= emacs-major-version 22)) ; for 22 or former
(defvar emacs23-p (<= emacs-major-version 23))  ; for 23
(defvar emacs24-p (>= emacs-major-version 24))  ; for 24
(defvar darwin-p (eq system-type 'darwin))      ; for Mac OS X
(defvar nt-p (eq system-type 'windows-nt))      ; for Windows
;; -----------------------------------------------------------
;; - user-emacs-directory (for 22 or former)
;; - my:user-emacs-config-directory    → ~/.emacs.d/config
;; - my:user-emacs-temporary-directory → ~/.emacs.d/tmp
;; - my:user-emacs-share-directory     → ~/.emacs.d/share
;;
(when oldemacs-p
  (defvar user-emacs-directory
    (expand-file-name (concat (getenv "HOME") "/.emacs.d/"))))
(defconst my:user-emacs-config-directory
  (expand-file-name (concat user-emacs-directory "config/")))
(defconst my:user-emacs-temporary-directory
  (expand-file-name (concat user-emacs-directory "tmp/")))
(defconst my:user-emacs-share-directory
  (expand-file-name (concat user-emacs-directory "share/")))
;; -----------------------------------------------------------
;; check dropbox installed
;;
(defvar my:check-dropbox
  (file-exists-p (concat (getenv "HOME") "/Dropbox")))
(if my:check-dropbox
    (defvar my:dropbox (concat (getenv "HOME") "/Dropbox/")))
;; -----------------------------------------------------------
;; func for adding load-pathes recursively
;; dirs that arent wanted to be read, named starting with '.' or '_'
;;
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-loadpath)
            (normal-top-level-add-subdirs-to-load-path))))))
;; -----------------------------------------------------------
;; adding load-path
;; mkdir these preveously
;;;check priority by  M-x list-load-path-shadows
(add-to-load-path
 "elisp"
 "elpa"
 "auto-install"
 "config"
 "submodules"
 "el-get/el-get"
 )
;; (require 'info)
;; (add-to-list 'Info-additional-directory-list "info")

;; -----------------------------------------------------------
;; el-get installation
;;
(setq-default el-get-emacswiki-base-url
              "http://raw.github.com/emacsmirror/emacswiki.org/master/")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
     (goto-char (point-max))
     (eval-print-last-sexp))))
;;; recipe: default
(add-to-list 'el-get-recipe-path
             (expand-file-name (concat user-emacs-directory "recipes")))
;;; access to github via https(considering proxy env.)
(setq el-get-github-default-url-type 'https)

(setq my-packages
      (append
       '(el-get helm switch-window vkill nxhtml xcscope yasnippet)
       (mapcar 'el-get-source-name el-get-sources)))
(el-get 'sync my-packages)
;cmigemo https://github.com/koron/cmigemo
;ddskk https://github.com/hsaito/ddskk
;html-fold https://github.com/ataka/html-fold
;; -----------------------------------------------------------
;; elpa installation
;;
;;;ELPA (Emacs23)
;;see also: http://emacswiki.org/emacs/ELPA
;; (require 'package)
;; (setq package-enable-at-startup nil)
;; (package-initialize)
;;use the GNU ELPA plus other repositories 
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
;; installation
(eval-when-compile (require 'cl))
(defvar ash-packages
  '(
    auto-complete
    auto-install
    auto-save-buffers-enhanced
    bm
    caml
    clojure-mode
    color-moccur
    color-theme
    cursor-chg
    dropdown-list ;for yasnippet
    ess
    ediprolog
    fill-column-indicator ;http://www.emacswiki.org/emacs/FillColumnIndicator
    fold-dwim
    ggtags
    goto-chg
    highlight-indentation ;http://www.emacswiki.org/emacs/HighlightIndentation
    highlight-symbol ;http://www.emacswiki.org/emacs/HighlightSymbol
    markdown-mode ;http://moonstruckdrops.github.io/blog/2013/03/24/markdown-mode/
    migemo
    nrepl
    org
    paredit
    point-undo
    popup ; for auto-complete
    protobuf-mode ;http://code.google.com/p/protobuf/
;    raibow-delimiters
    rainbow-mode ;http://julien.danjou.info/projects/emacs-packages
    recentf-ext
    redo+
    s
    scala-mode2
    sequential-command
    shell-pop
    simplenote
    summarye
    tuareg
    twittering-mode
    undo-tree
    ))

(package-initialize)
;;; install missing packages
(let ((not-installed (remove-if 'package-installed-p ash-packages)))
  (if not-installed
      (if (y-or-n-p (format "there are %d packages to be installed. install them? "
                            (length not-installed)))
          (progn (package-refresh-contents)
                 (dolist (package not-installed)
                   (package-install package))))))
;; -----------------------------------------------------------
;;;auto-install.el
;(require 'auto-install)
;;to update package name when start up(internet connection necessarry):
;(auto-install-update-emacswiki-package-name t)
;; -----------------------------------------------------------
;;ddskk
;;https://github.com/hsaito/ddskk
;;in installing, add this to SKK-CFG in ddskk-*, & check "make what-where"
(setq SKK_DATADIR "share/skk")
(setq SKK_INFODIR "share/info")
(setq SKK_LISPDIR "elisp/skk")
(setq SKK_SET_JISYO t)
;;copy SKK-JISYO.L in "dic" directory, then make install
;;then skk-setup.el is loaded automatically
(require 'skk-autoloads)
;(global-set-key "\C-x\C-j" 'skk-mode)
;(global-set-key "\C-xj" 'skk-auto-fill-mode)
;; -----------------------------------------------------------
;;;micellenious settings--------------------------------------
;;keybinds
(global-set-key "\C-h" 'delete-backward-char)
(eval-after-load "helm"
  '(define-key helm-map (kbd "C-h") 'delete-backward-char))
(global-set-key "\C-j" 'newline-and-indent)
(global-set-key "\M-g" 'goto-line)
(defun line-to-top-of-window () (interactive) (recenter 0))
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p) (split-window-horizontally))
  (other-window 1))
(global-set-key "\C-t" 'other-window-or-split)
(global-set-key "\C-c;" 'comment-or-uncomment-region)
(global-set-key "\C-c\C-u" 'dired-jump)
(global-set-key "\C-c\C-d" 'delete-region)
(global-set-key "\C-c\C-h" 'help-command)
;; -----------------------------------------------------------
;;;dont show toolbar
(tool-bar-mode nil)
;;;dont show dialogue box
(setq use-dialog-box nil)
(defalias 'message-box 'message)
;;;maximize frame
(set-frame-parameter nil 'fullscreen 'maximized)
;;;color the current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "SlateBlue4")
;;;color the region
(transient-mark-mode 1)
;;;show the correspoinding parenthesis
(show-paren-mode 1)
;;;show line column number
(line-number-mode 1)
(column-number-mode 1)
;;;rapidly show the key stroke in echo area
(setq echo-keystrokes 0.1)
;;;yes is y
(defalias 'yes-or-no-p 'y-or-n-p)
;;;keep history till next startup
(savehist-mode 1)
;;;memorize the cursor place in file
(setq-default save-place t)
(require 'saveplace)
;;;expand the length of log
(setq message-log-max 10000)
;;;save the input of minibuffer in history evenif its cancelled
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))
;;;warning when large size file is opend(25MB over(10MB is default))
(setq large-file-warning-threshold (* 25 1024 1024))
;;;transparent emacs
;;(require 'cl)
;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
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
(global-set-key (kbd "C-c t") 'toggle-transparency)
;;color theme
(require 'color-theme) ;;no need if installed from ELPA
(color-theme-initialize)
(color-theme-shaman)
;;fill-column-indicator
;; fci-mode
(require 'fill-column-indicator)
;; -----------------------------------------------------------
;;;sequential-command
;;extend the function of C-a, C-e
(require 'sequential-command-config)
(sequential-command-setup-keys)
;;;buffer&file------------------------------------------------
;;;ffap:set the default open file url to the current place
(ffap-bindings)
;;;iswitchb:improve the completion of switch-to-buffer
(iswitchb-mode 1)
(setq read-buffer-function 'iswitchb-read-buffer)
;;use partial string, not regexp
(setq iswitchb-regexp nil)
;;dont ask when making new buffer
(setq iswitchb-prompt-newbuffer- nil)
;;;ido:use iswitchb completion with file-open
(ido-mode 1)
(ido-everywhere 1)
;; -----------------------------------------------------------
;;;uniquify
(require 'uniquify)
;;filename<dir>
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;;*filename* is excepted
(setq uniquify-ignore-buffers-re "*[^*]+*")
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
	    (load "dired-x")
	    (global-set-key "\C-x\C-j" 'skk-mode)))
;; -----------------------------------------------------------
;;;undo-tree
;;"C-/" is arranged to normal undo
 (when (require 'undo-tree nil t)
   (global-undo-tree-mode))
;; -----------------------------------------------------------
;;;recentf-ext.el:list & open recently used files & directories
;;M-x install-elisp-from-emacswiki recentf-ext.el
(require 'recentf-ext)
(setq recentf-max-saved-items 1000)
(setq recentf-exclude '("/TAGS$" "/var/tmp/"))
(global-set-key "\C-z" 'recentf-open-files)
;; -----------------------------------------------------------
;;;auto-save-buffers-enhanced: save editting files automatically
(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-interval 1) ; 指定のアイドル秒で保存
(auto-save-buffers-enhanced t)
;; -----------------------------------------------------------
;;;emacsclient:dont restart Emacs when editing files from an external program
;;emacsclient filename (external program)
;;add this setting .bashrc: export EDITOR=emacsclient
(server-start)
(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))
;;uncomment to iconify Emacs when editting is done
;;(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
(global-set-key "\C-x\C-c" 'server-edit)
;;finish Emacs with M-x exit not C-x C-c
(defalias 'exit 'save-buffers-kill-emacs)
;; -----------------------------------------------------------
;;;point-undo
;;M-x install-elisp-from-emacswiki point-undo.el
;;save every movement of cursor
;;usage press f7,Shift-f7
(require 'point-undo)
(define-key global-map [f7] 'point-undo)
(define-key global-map [S-f7] 'point-redo)
;; -----------------------------------------------------------
;;;goto-chg
;;save every place of changes
;;usage press f7,Shift-f7
(require 'goto-chg)
(global-set-key [f8] 'goto-last-change)
(global-set-key [S-f8] 'goto-last-change-reverse)
;; -----------------------------------------------------------
;;;bm.el
;;highlight the location of cursor 
;;M-x install-elisp http://cvs.savannah.gnu.org/viewvc/*checkout*/bm/bm/bm.el
;;usage M-SPC on the place to mark on
;;press M-[,M-] to move for/back
(setq-default bm-buffer-persistence nil)
(setq bm-restore-repository-on-load t)
(require 'bm)
(add-hook 'find-file-hooks 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-vefore-checkin-hook 'bm-buffer-save)
(global-set-key "\M-@" 'bm-toggle)
(global-set-key "\M-[" 'bm-previous)
(global-set-key "\M-]" 'bm-next)
;; -----------------------------------------------------------
;; search&replace---------------------------------------------
;;M-%
(global-set-key "\C-cr" 'query-replace)
;;M-S-%
(defalias 'qrr 'query-replace-regexp)
;; -----------------------------------------------------------
;;;color-occur
;;;;M-x install-elisp-from-emacswiki color-occur.el
;(require 'color-occur)
;(setq moccur-split-word t) ;match multiple words splitted by SPC
;;;color-moccur
;; -----------------------------------------------------------
;; input support----------------------------------------------
;;;autoinsert
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/autoinsert/")
(define-auto-insert "\\.py$" "template.py")
(define-auto-insert 'python-mode "template.py")
;; -----------------------------------------------------------
;;;cua-mode
;;C-Enter(rectangle region)
(cua-mode t)
(setq cua-enable-cua-keys nil)
;; -----------------------------------------------------------
;;;redo+
(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t)
(setq undo-limit 600000)
(setq undo-strong-limit 900000)
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
;;;yasnippet
;;(add-to-list 'load-path "~/Dropbox/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas--initialize)
;;(yas/load-directory "~/Dropbox/.emacs.d/plugins/yasnippet/snippets")
;;(setq yas/snippet-dirs "~/Dropbox/.emacs.d/snippets")
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/ido-prompt
                             yas/completing-prompt))
;; -----------------------------------------------------------
;;auto-complete
;;manual:http://cx4a.org/software/auto-complete/manual.ja.html
(require 'auto-complete-config)
(ac-config-default)
;;(ac-dwim t)
(global-auto-complete-mode 1)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(ac-set-trigger-key "TAB")
;;(add-to-list 'ac-sources 'ac-source-yasnippet)
;;complete from some other source
;;setq ac-sources(whichis buffer-local var) "pre-defined symbbol"
;;ex.complete Emacs Lisp symbol in emacs-lisp-mode
(defun emacs-lisp-ac-setup ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-symbols)))
(add-hook 'emacs-lisp-mode-hook 'emacs-lisp-ac-setup)
;; -----------------------------------------------------------
;;;Helm
;;referto ; http://sleepboy-zzz.blogspot.jp/2012/09/anythinghelm.html
;; ミニバッファで C-h でヘルプでないようにする
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(require 'helm-command)
;(require 'helm-descbinds)
(require 'helm-files)
(setq helm-idle-delay             0.3
      helm-input-idle-delay       0.3
      helm-candidate-number-limit 200
      helm-c-locate-command "locate-with-mdfind %.0s %s")
(let ((key-and-func
       `((,(kbd "C-c C-f")   helm-for-files)
         (,(kbd "C-;")   helm-c-apropos)
         (,(kbd "C-;")   helm-resume)
         (,(kbd "M-s")   helm-occur)
         (,(kbd "M-x")   helm-M-x)
         (,(kbd "M-y")   helm-show-kill-ring)
         (,(kbd "M-z")   helm-do-grep)
         (,(kbd "C-S-h") helm-descbinds)
        ))))
;; -----------------------------------------------------------
;;;migemo
;;ruby1.6later, APEL(http://git.chise.org/elisp/dist/semi/), Ruby/Bsearch, Ruby/Romkan is required
;;put ruby libraries in the path shown by "ruby -e 'puts $:'"
;;https://github.com/emacs-jp/migemo
;;https://github.com/koron/cmigemo
;;build&install cmigemo! https://github.com/koron/cmigemo/blob/master/doc/README_j.txt
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
;; Set your installed path
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)
;; -----------------------------------------------------------
;;;text editting----------------------------------------------
;;simplenote.el
(require 'simplenote)
(setq simplenote-email "inatchenator@gmail.com")
(setq simplenote-password nil)
(simplenote-setup)
;; -----------------------------------------------------------
;;twittering-mode
(require 'twittering-mode)
(setq twittering-use-master-password t)
(setq twittering-icon-mode t)
(setq twittering-timer-interval 300)
(defun twittering-mode-hook-func ()
  (set-face-bold-p 'twittering-username-face t)
  (set-face-foreground 'twittering-username-face "DeepSkyBlue3")
  (set-face-foreground 'twittering-uri-face "gray35")
  (define-key twittering-mode-map (kbd "<") 'my-beginning-of-buffer)
  (define-key twittering-mode-map (kbd ">") 'my-end-of-buffer)
  (define-key twittering-mode-map (kbd "F") 'twittering-favorite))
;; -----------------------------------------------------------
;;;programming------------------------------------------------
;;summarye.el
;;M-x install-from-emacswiki summarye.el
(require 'summarye)
;; -----------------------------------------------------------
;;hideshow.el, fold-dwim.el
(when (require 'fold-dwim nil t)
  (require 'hideshow nil t)
  ;; 機能を利用するメジャーモード一覧
  (let ((hook))
    (dolist (hook
             '(emacs-lisp-mode-hook
               c-mode-common-hook
               python-mode-hook
               php-mode-hook
               ruby-mode-hook
               js2-mode-hook
               css-mode-hook
               apples-mode-hook))
      (add-hook hook 'hs-minor-mode))))
(define-key global-map (kbd "C-#") 'fold-dwim-toggle)
;; -----------------------------------------------------------
;;M-x which-func-mode
;;always show current func name
;;to change color andsoon M-x customize-group RET which-Func
(which-func-mode 1)
(setq which-func-modes t)
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq-default header-line-format '(which-func-mode ("" which-func-format)))
;; -----------------------------------------------------------
;;ggtags.el
;;M-x imenu(jump to function)
;;M-.
;;install 'global'
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))
;; -----------------------------------------------------------
(require 'shell-pop)
(custom-set-variables
 '(shell-pop-default-directory "~/Dropbox/work")
 '(shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
 '(shell-pop-term-shell "/bin/zsh")
 '(shell-pop-universal-key "C-'")
 '(shell-pop-window-height 60)
 '(shell-pop-window-position "bottom"))

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
;;;C
;;gdb
(setq gdb-many-windows t)
;;compile、next-error、 gdbを簡単に呼び出す。
(add-hook 'c-mode-hook
	  (lambda ()
	    (define-key c-mode-base-map "\C-c\C-c" 'comment-region)
	    (define-key c-mode-base-map "\C-c\M-c" 'uncomment-region)
	    (define-key c-mode-base-map "\C-cc" 'compile)
	    (define-key c-mode-base-map "\C-ce" 'next-error)
	    (define-key c-mode-base-map "\C-cd" 'gdb)
	    (define-key c-mode-base-map "\C-ct" 'toggle-source)
	    ))
;;auto-indentation
(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (c-toggle-auto-state 1)))
;;fold-dwim
;;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent) ;other way
(add-hook 'gdb-mode-hook
	  '(lambda ()
	    (if ecb-minor-mode
		(ecb-deactivate))))
;;hideif.el
;;#ifdef 部分を隠す
(require 'hideif)
(add-hook 'c-mode-common-hook 'hide-ifdef-mode)
;; -----------------------------------------------------------
;;;Python
(define-key global-map
  "\C-cp" 'run-python)
;; (add-hook 'python-mode-hook
;; 	  '(lambda ()
;; 	     (define-key python-mode-map "\C-m" 'newline-and-indent)))
;; -----------------------------------------------------------
;;R ESS
(require 'ess-site)
(require 'ess-eldoc) ;;display args
(add-hook 'inferior-ess-mode-hook 'ess-use-eldoc)
;; C-M-a ess-beginning-of-function
;; C-M-e ess-end-of-function
;; C-M-h ess-mark-function
;; C-c C-v start *R*
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
;; -----------------------------------------------------------
;;Clojure
;;clojurer-mode.el, paredit.el, nrepl.el, rainbow-delimiters.el
;;http://matstani.github.io/blog/2013/04/19/clojure-dev-env-emacs/
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)
;; -----------------------------------------------------------
;;;OCaml
;;tuareg-mode
;;C-c C-e:eval
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(autoload 'tuareg-mode "tuareg" "Major mode for editing OCaml code" t)
(autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process." t)
(autoload 'ocamldebug "ocamldebug" "Run the OCaml debugger" t)
;; -----------------------------------------------------------
;;;Prolog
(setq auto-mode-alist
  (cons (cons "\\.pl" 'prolog-mode)
     auto-mode-alist))
;;ediprolog
;;http://www.logic.at/prolog/ediprolog/ediprolog.el
(require 'ediprolog)
(global-set-key "\C-c\C-e" 'ediprolog-dwim)
;; -----------------------------------------------------------
;;;html
;;html-fold
;;https://raw.github.com/ataka/html-fold/master/html-fold.el
;;read more http://at-aka.blogspot.jp/2005/07/html-foldel-alpha1-htmlemacs.html
(require 'html-fold)
(autoload 'html-fold-mode "html-fold" "Minor mode for hiding and revealing elements." t)
(add-hook 'html-mode-hook 'html-fold-mode)
;;hidden inline factors 
(setq html-fold-inline-list
      '(("[a:" ("a"))
	'("[c:" ("code"))
	'("[k:" ("kbd"))
	'("[v:" ("var"))
	'("[s:" ("samp"))
	'("[ab:" ("abbr" "acronym"))
	'("[lab:" ("label"))
	'("[opt:" ("option"))
	
	'("[rss:" ("rss"))
	'("[link:" ("link"))
))
;;hidden block factors 
(setq html-fold-block-list
      '("script" "style" "table"
	;;rss setting
      "description" "content" ))
;; -----------------------------------------------------------
;;; YaTeX with TeX Live 2013
;; https://github.com/emacsmirror/yatex
;; C-c t j (platex)
;; C-c t p (xdvi)
;; C-c t d (pdflatex)
;;more command in info file(M-x info m yatex)
;(require 'yatex)
(setq section-name "section"
      YaTeX-no-begend-shortcut t ;Begin ショートカットの禁止(いきなり補完入力)
      YaTeX-create-file-prefix-g t ;[prefix] g で相手のファイルがなかったら新規作成
;      YaTeX-template-file (expand-file-name "~/Dropbox/work/tex/template/template.tex") ;新規ファイル作成時に自動挿入されるファイル名
)
;;for skk
(add-hook 'skk-mode-hook
  (lambda () (if (eq major-mode 'yatex-mode)
		 (progn
		   (define-key skk-j-mode-map "\\" 'self-insert-command)
		   (define-key skk-j-mode-map "$" 'YaTeX-insert-dollar)))))
;;http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?YaTeX
;;fwdevince http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Evince%2Ffwdevince
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
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
(setq dvi2-command "evince")
(setq dviprint-command-format "acroread `echo %s | sed -e \"s/\\.[^.]*$/\\.pdf/\"`")
(defun evince-forward-search ()
  (interactive)
  (progn
    (process-kill-without-query
     (start-process
      "fwdevince"
      nil
      "fwdevince"
      (expand-file-name
       (concat (file-name-sans-extension (or YaTeX-parent-file
                                             (save-excursion
                                               (YaTeX-visit-main t)
                                               buffer-file-name)))
               ".pdf"))
      (number-to-string (save-restriction
                          (widen)
                          (count-lines (point-min) (point))))
      (buffer-name)))))
(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map (kbd "C-c e") 'evince-forward-search)))
(require 'dbus)
(defun un-urlify (fname-or-url)
  "A trivial function that replaces a prefix of file:/// with just /."
  (if (string= (substring fname-or-url 0 8) "file:///")
      (substring fname-or-url 7)
    fname-or-url))
(defun evince-inverse-search (file linecol &rest ignored)
  (let* ((fname (un-urlify file))
         (buf (find-file fname))
         (line (car linecol))
         (col (cadr linecol)))
    (if (null buf)
        (message "[Synctex]: %s is not opened..." fname)
      (switch-to-buffer buf)
      (goto-line (car linecol))
      (unless (= col -1)
        (move-to-column col)))))
(dbus-register-signal
 :session nil "/org/gnome/evince/Window/0"
 "org.gnome.evince.Window" "SyncSource"
 'evince-inverse-search)

(add-hook 'yatex-mode-hook
          '(lambda ()
             (auto-fill-mode -1)))
;;
;; RefTeX with YaTeX
;;
;(add-hook 'yatex-mode-hook 'turn-on-reftex)
(add-hook 'yatex-mode-hook
          '(lambda ()
             (reftex-mode 1)
             (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
             (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))
;; -----------------------------------------------------------
;;数式の色付け
(if (featurep 'hilit19)
      (hilit-translate
       formula 'DeepPink1))
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(which-function-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(which-func ((t (:foreground "yellow")))))
;; -----------------------------------------------------------
;;;auto-complete-latex
;; https://bitbucket.org/tequilasunset/auto-complete-latex/src/6c534e773374?at=version%200.1.3
(require 'auto-complete-latex)
(setq ac-l-dict-directory "~/.emacs.d/share/ac-l-dict/")
;; (add-to-list 'ac-modes 'foo-mode)
;; (add-hook 'foo-mode-hook 'ac-l-setup)
;; (setq ac-l-source-user-keywords*
;;       '("aaa" "bbb" "ccc"))
;; -----------------------------------------------------------
;; -----------------------------------------------------------
;;;org-mode
;;M-x org-insert-heading-dwim
;;C-RET, C-u C-RET, C-u C-u C-RET
(require 'org-install)
(require 'org)
(defun org-insert-upheading (arg)
  (interactive "P")
  (org-insert-heading arg)
  (cond ((org-on-heading-p) (org-do-promote))
	((org-insert-item-p) (org-insert-item -1))))
(defun org-insert-heading-dwim (arg)
  (interactive "p")
  (case arg
    (4 (org-insert-subheading nil)) ;C-u
    (16 (org-insert-upheading nil)) ;C-u C-u
    (t (org-insert-heading nil))))
(define-key org-mode-map (kbd "<C-return>") 'org-insert-heading-dwim)
;; -----------------------------------------------------------
;;org-babel
;; #+BEGIN_SRC emacs-lisp
;; code
;; #+END_SRC
;; C-c '
(require 'ob)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)))
(add-to-list 'org-babel-tangle-lang-exts '("clojure" . "clj"))
(defvar org-babel-default-header-args:clojure
  '((:results . "silent") (:tangle . "yes")))
(defun org-babel-execute:clojure (body params)
  (lisp-eval-string body)
  "Done!")
(provide 'ob-clojure)
(setq org-src-fontify-natively t)
(setq org-confirm-babel-evaluate nil)

;;yasnipet for org-mode
(add-hook 'org-mode-hook
          (lambda ()
            (org-set-local 'yas/trigger-key [tab])
            (define-key yas/keymap [tab] 'yas/next-field-group)))

;; (defun yas/org-very-safe-expand ()
;; (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
;; (add-hook 'org-mode-hook
;;   (lambda ()
;;     (org-set-local 'yas/trigger-key [tab])
;;     (define-key yas/keymap [tab] 'yas/next-field-group)
;;     ;;yasnippet (using the new org-cycle hooks)
;;     (setq ac-use-overriding-local-map t)
;;     (make-variable-frame-local 'yas/trigger-key)
;;     (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)))

;;M-x org-remember
;(require 'org)
(setq org-directory "~/memo/")
(setq org-default-notes-file (expand-file-name "memo.org" org-directory))
(setq org-remember-templates
      '(("Note" ?n "** %?\n  %i\n  %t" nil "Inbox")
	("Todo" ?t "** TODO %?\n  %i\n  %a\n %t" nil "Inbox")))
;select template: [n]ote [t]odo
;;refer to ChangeLog(C-u C-x 4 a), hown(http://howm.sourceforge.jp/index-j.html), Planner(http://download.gna.org/planner-el)
;; -----------------------------------------------------------







;;;input method-------------------------------------------
;;uim.el, add uim manually
;;if cannot read, check if /usr/local/lib is added to /etc/ld.so.conf (or /etc/ld.so.conf.d/local.conf)
;;(require 'uim)
;; uncomment next and comment out previous to load uim.el on-demand
;; (autoload 'uim-mode "uim" nil t)
;; set default IM (ex. use Anthy)
;;(setq uim-default-im-engine "skk")
;; key-binding for activate uim
;;(global-set-key "\C-o" 'uim-mode)
;; Set UTF-8 as preferred character encoding (default is euc-jp).
;; (setq uim-lang-code-alist
;;       (cons '("Japanese" "Japanese" utf-8 "UTF-8")
;;            (delete (assoc "Japanese" uim-lang-code-alist) 
;;                    uim-lang-code-alist)))
;; set inline candidates displaying mode as default
;;(setq uim-candidate-display-inline t)
;;uim-1.8.3
;; (setq load-path
;;       (cons "~/Dropbox/.emacs.d/elisp/uim-el" load-path))
;; (setq uim-el-agent "~/Dropbox/.emacs.d/elisp/uim-el/uim-el-agent")
;;;installation--------------------------------------------
;;;install-elisp.el
;;no need to install?
;;http://emacswiki.org/emacs/install-elisp.el
 ;; (require 'install-elisp)
 ;; (setq install-elisp-repository-directory "~/Dropbox/.emacs.d/elisp/")
