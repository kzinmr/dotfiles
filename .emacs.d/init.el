;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil -*-
;; -----------------------------------------------------------
;; func for adding load-pathes recursively
;; dirs that arent wanted to be read, named starting with '.' or '_'
;;
(require 'cl-lib)

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-loadpath)
            (normal-top-level-add-subdirs-to-load-path))))))
;;;check priority(& hidden dirs) by  M-x list-load-path-shadows
(add-to-load-path
 "el-get/el-get"
 "elisp"
 "elpa"
 "submodules"
 "dummy"
 )
;; (require 'info)
;; (add-to-list 'Info-additional-directory-list "info")

;; -----------------------------------------------------------
;; Emacs 24.4 or later
(fset 'package-desc-vers 'package--ac-desc-version)
;; elpa installation
;;
;(package-refresh-contents)
(package-initialize)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq url-http-attempt-keepalives nil) ; To fix MELPA problem.

(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    ;el-get
    auto-install
    init-loader
    ;apprearance
    ; auto-install-from-emacs-wiki fill-column-indicator
    highlight-indentation
    highlight-symbol
    yascroll
    ;buffer
    auto-save-buffer-enhanced
    bm
    goto-chg
    zlc
    helm
    ;editting
    migemo
    color-moccur
    ; auto-install-from-emacs-wiki moccur-edit
    fold-dwim
    rainbow-mode
    open-junk-file
    point-undo
    recentf-ext
    redo+
    visual-regexp-steroids
    ;programming
    auto-async-byte-compile
    ggtags
    git-gutter-fringe
    flycheck
    c-eldoc
    eldoc-extension
    iedit
    magit
    ))

;;; install missing packages
(defvar ash-packages '( ))
(let ((not-installed (cl-remove-if 'package-installed-p ash-packages)))
  (if not-installed
      (if (y-or-n-p (format "there are %d packages to be installed. install them? "
                            (length not-installed)))
          (progn (package-refresh-contents)
                 (dolist (package not-installed)
                   (package-install package))))))
;; -----------------------------------------------------------
;; install auto-install
(require 'auto-install)
(add-to-list 'load-path "~/.emacs.d/auto-install")
;; emacsの起動時にEmacsWikiからパッケージ名を取得する
(auto-install-update-emacswiki-package-name t)
;; 古いinstall-elisp.el互換モードに設定
(auto-install-compatibility-setup)

;; install init-loader
(require 'init-loader)
(setq init-loader-show-log-after-init nil
      init-loader-byte-compile t)
(init-loader-load "~/.emacs.d/init-loader")
;;   hide compilation results
(let ((win (get-buffer-window "*Compile-Log*")))
  (when win (delete-window win)))

;; -----------------------------------------------------------
(require 'generic-x)
;; -----------------------------------------------------------
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; el-get installation
;; bundle (an El-Get wrapper): https://github.com/tarao/bundle-el
;; (setq-default el-get-emacswiki-base-url
;;   "http://raw.github.com/emacsmirror/emacswiki.org/master/")
;; (add-to-list 'load-path (locate-user-emacs-file "el-get/bundle"))
;; (unless (require 'bundle nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "http://raw.github.com/tarao/bundle-el/master/bundle-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))
;; (add-to-list 'el-get-recipe-path (locate-user-emacs-file "recipes"))

;; load init files

;; (bundle! emacs-jp/init-loader
;;  (setq-default init-loader-show-log-after-init nil
;;                init-loader-byte-compile t)
;;  (init-loader-load "~/.emacs.d/init-loader")
;;   hide compilation results
;;  (let ((win (get-buffer-window "*Compile-Log*")))
;;    (when win (delete-window win))))

;(setq el-get-user-package-directory (locate-user-emacs-file "init"))
;;; access to github via https(considering proxy env.)
;; (setq el-get-github-default-url-type 'https)
;; (setq debug-on-error t)
;; -----------------------------------------------------------

;(bundle! dash)
;(bundle! s)
;(bundle! f)
;(bundle! let-alist)

;; -----------------------------------------------------------
;;ProofGeneral for Coq
;(load-file (concat (getenv "HOME") "/build/ProofGeneral/generic/proof-site.el"))
