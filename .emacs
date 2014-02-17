;;;
;;; .emacs (2008/05/29 -)
;;;

(set-default-coding-systems 'utf-8)

(setq make-backup-files nil)

(setq-default indent-tabs-mode nil)

(show-paren-mode)

(global-set-key "\C-j" 'newline)
(global-set-key "\C-o" 'dabbrev-expand)

(global-font-lock-mode t)

(add-to-list 'default-frame-alist '(font . "fontset-default"))
(set-frame-font "fontset-default")

(setq inhibit-startup-message t)

(menu-bar-mode 0)

(setq transient-mark-mode t)

(setq column-number-mode t)

;; C-mode
(defun my-c-mode-hook ()
  (c-set-style "K&R")
  (setq tab-width 4)
  (setq c-basic-offset tab-width))
(add-hook 'c-mode-hook 'my-c-mode-hook)

(defun my-c-common-mode ()
  (c-toggle-hungry-state 1))
(add-hook 'c-mode-common-hook 'my-c-common-mode)

;; Haskell mode
;(add-to-list 'load-path "~/ghc-mod/elisp/")
(setq exec-path (cons "/home/egi/ghc-mod/.cabal-sandbox/bin/" exec-path))

(autoload 'ghc-init "ghc" nil t)
;(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))

(setq haskell-program-name "/usr/bin/ghci")

;; Egison mode
(load-file "~/egison3/elisp/egison-mode.el")
(autoload 'egison-mode "egison-mode" "Major mode for editing Egison code." t)
(setq auto-mode-alist
      (cons `("\\.egi$" . egison-mode) auto-mode-alist))

;; Marmalade setting
(require 'package)
(add-to-list 'package-archives
                 '("marmalade" .
                         "http://marmalade-repo.org/packages/"))
(package-initialize)
