;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     python
     markdown
     ruby
     yaml
     html
     python
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     ;; auto-completion
     ;; better-defaults
     emacs-lisp
     ;; git
     ;; markdown
     ;; org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control
     scala
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update 1
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro for Powerline"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  (global-set-key (kbd "C-x C-z") 'open-junk-file)
  (global-set-key "\C-t" 'other-window)
  (global-set-key "\C-h" 'delete-backward-char)

  (set-frame-parameter (selected-frame) 'alpha '(85 50))
  (add-to-list 'default-frame-alist '(alpha 75 50))
  (defun toggle-transparency ()
    (interactive)
    (if (/=
         (cadr (frame-parameter nil 'alpha))
         100)
        (set-frame-parameter nil 'alpha '(90 100))
      (set-frame-parameter nil 'alpha '(15 25))))
  (global-set-key [f9] 'toggle-transparency)

  ;; linum
  (when (require 'linum nil t)
    (global-set-key (kbd "M-n") #'linum-mode)
    (set-face-attribute 'linum nil :foreground "aquamarine4")
    (setq linum-format "%5d")
    (set-face-attribute 'linum nil :height 0.75))

  (global-hl-line-mode t)
  (set-face-background 'hl-line "SlateBlue4")
  (defun global-hl-line-timer-function ()
    (global-hl-line-unhighlight-all)
    (let ((global-hl-line-mode t))
      (global-hl-line-highlight)))
  (setq global-hl-line-timer
        (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))

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

;;yes is y
(fset 'yes-or-no-p 'y-or-n-p)

; clipboard <-> kill-ring
(global-set-key [(shift delete)] 'clipboard-kill-region)
(global-set-key [(control insert)] 'clipboard-kill-ring-save)
(global-set-key [(shift insert)] 'clipboard-yank)

;; create backup file in ~/.emacs.d/backup
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
            backup-directory-alist))
;; create auto-save file in ~/.emacs.d/backup
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backup/") t)))
; memorize the cursor place in file
(when (require 'saveplace nil t)
  (setq-default save-place t)
  (setq save-place-file "~/.emacs.d/places"))
; expand the length of log
(setq message-log-max 10000)
; warn when large(25MB~) size file is opend(10MB is default)
(setq large-file-warning-threshold (* 25 1024 1024))
;;;ffap:set the default open file url to the current place
(ffap-bindings)
;; Automatically reload files was modified by external program
(global-auto-revert-mode 1)
; emacsclient
;;in shell config file: export EDITOR=emacsclient
(server-start)
(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))
;;uncomment to iconify Emacs when editting is done
;; (add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
(global-set-key "\C-x\C-c" 'server-edit)
;;finish Emacs with M-x exit not C-x C-c
(defalias 'exit 'save-buffers-kill-emacs)
;; (defun insert-bracket-pair (leftBracket rightBracket)
;;   (if (region-active-p)
;;       (let ((p1 (region-beginning))
;;             (p2 (region-end)))
;;         (goto-char p2)
;;         (insert rightBracket)
;;         (goto-char p1)
;;         (insert leftBracket)
;;         (goto-char (+ p2 2)))
;;     (progn
;;       (insert leftBracket rightBracket)
;;       (backward-char 1))))
;; (defun insert-pair-brace () (interactive) (insert-bracket-pair "{" "}") )
;; (defun insert-pair-paren () (interactive) (insert-bracket-pair "(" ")") )
;; (defun insert-pair-double-straight-quote () (interactive) (insert-bracket-pair "\"" "\"") )
;; (defun insert-pair-single-straight-quote () (interactive) (insert-bracket-pair "'" "'") )
;; (defun insert-pair-bracket () (interactive) (insert-bracket-pair "[" "]") )
;; (defun insert-pair-angle-bracket () (interactive) (insert-bracket-pair "<" ">") )
;; (define-key global-map "{" 'insert-pair-brace)
;; (define-key global-map "(" 'insert-pair-paren)
;; (define-key global-map "\"" 'insert-pair-double-straight-quote)
;; (define-key global-map "'" 'insert-pair-single-straight-quote)
;; (define-key global-map "[" 'insert-pair-bracket)
;; (define-key global-map "<" 'insert-pair-angle-bracket)

  ;; for ddskk
;  (when (require 'skk nil t)
;   (global-set-key (kbd "C-x j") 'skk-auto-fill-mode)
;   (setq default-input-method "japanese-skk")
;   (require 'skk-study)
;   ;; use skkserve
;   (setq skk-server-host "localhost")
;   (setq skk-server-portnum 1178)
                                        ;   )
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

;; Set your installed path
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(migemo-init)
(with-eval-after-load "helm"
  (helm-migemo-mode 1)
  )
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ac-ispell ace-jump-helm-line ace-link ace-window adaptive-wrap aggressive-indent alert anaconda-mode anzu async auto-compile auto-complete auto-dictionary auto-highlight-symbol auto-yasnippet avy avy-migemo bind-key bind-map bundler ccc cdb chruby clang-format clean-aindent-mode cmake-mode cmm-mode coffee-mode column-enforce-mode company company-anaconda company-c-headers company-cabal company-ghc company-ghci company-statistics company-tern cython-mode dactyl-mode dash dash-functional ddskk define-word diminish disaster dumb-jump elisp-slime-nav emmet-mode ensime epl eval-sexp-fu evil evil-anzu evil-args evil-ediff evil-escape evil-exchange evil-iedit-state evil-indent-plus evil-lisp-state evil-magit evil-matchit evil-mc evil-nerd-commenter evil-numbers evil-search-highlight-persist evil-surround evil-tutor evil-tutor-ja evil-unimpaired evil-visual-mark-mode evil-visualstar exec-path-from-shell expand-region eyebrowse f fancy-battery fill-column-indicator flx flx-ido flycheck flycheck-haskell flycheck-pos-tip flyspell-correct flyspell-correct-helm gh gh-md ghc gist git-commit git-link git-messenger git-timemachine gitattributes-mode gitconfig-mode github-browse-file github-clone github-search gitignore-mode gntp gnuplot golden-ratio google-translate goto-chg haml-mode haskell-mode haskell-snippets helm helm-ag helm-c-yasnippet helm-company helm-core helm-css-scss helm-dash helm-descbinds helm-flx helm-gitignore helm-hoogle helm-make helm-mode-manager helm-projectile helm-pydoc helm-swoop helm-themes help-fns+ hide-comnt highlight highlight-indentation highlight-numbers highlight-parentheses hindent hl-todo hlint-refactor ht htmlize hungry-delete hy-mode hydra ido-vertical-mode iedit indent-guide inf-ruby info+ intero japanese-holidays js-doc js2-mode js2-refactor json-mode json-reformat json-snatcher less-css-mode link-hint linum-relative live-py-mode livid-mode log4e logito lorem-ipsum macrostep magit magit-gh-pulls magit-gitflow magit-popup markdown-mode markdown-toc marshal migemo minitest mmm-mode move-text multiple-cursors mwim neotree noflet open-junk-file org org-bullets org-download org-plus-contrib org-pomodoro org-present org-projectile orgit package-build packed pangu-spacing paradox parent-mode pcache pcre2el pdf-tools persp-mode pip-requirements pkg-info popup popwin pos-tip powerline projectile pug-mode py-isort pyenv-mode pytest pythonic pyvenv quelpa rainbow-delimiters rake rbenv request restart-emacs robe rspec-mode rubocop ruby-test-mode ruby-tools rvm s sass-mode sbt-mode scala-mode scss-mode simple-httpd skewer-mode slim-mode smartparens smeargle spaceline spacemacs-theme spinner tablist tagedit tern toc-org undo-tree use-package uuidgen vi-tilde-fringe vimrc-mode volatile-highlights web-beautify web-mode which-key window-numbering winum with-editor ws-butler yaml-mode yapfify yasnippet zeal-at-point)))
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
