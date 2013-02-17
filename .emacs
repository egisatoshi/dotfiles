;;;
;;; .emacs (2008/05/29 - 2012/08/12)
;;;

(set-default-coding-systems 'utf-8)

(setq make-backup-files nil)

(setq-default indent-tabs-mode nil)

(show-paren-mode)

(global-set-key "\C-\\" 'compile)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-j" 'newline)
(global-set-key "\C-o" 'dabbrev-expand)

(global-font-lock-mode t)

(add-to-list 'default-frame-alist '(font . "fontset-default"))
(set-frame-font "fontset-default")
`
(setq inhibit-startup-message t)

(menu-bar-mode 0)

(setq transient-mark-mode t)

(setq column-number-mode t)

(autoload 'ansi-color-for-comint-mode-on "ansi-color"
     "Set `ansi-color-for-comint-mode' to t." t)

;; C-mode
(defun my-c-mode-hook ()
  (c-set-style "K&R")
  (setq tab-width 4)
  (setq c-basic-offset tab-width))
(add-hook 'c-mode-hook 'my-c-mode-hook)

(defun my-c-common-mode ()
  (c-toggle-hungry-state 1))
(add-hook 'c-mode-common-hook 'my-c-common-mode)

;; Scheme
(modify-coding-system-alist 'process "gosh" '(utf-8 . utf-8))

(setq scheme-program-name "gosh -i")

(autoload 'sbcheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

(defun scheme-other-window ()
	"Run scheme on other window"
	(interactive)
	(switch-to-buffer-other-window
	 (get-buffer-create "*scheme*"))
	(run-scheme scheme-program-name))
(define-key global-map
  "\C-cs" 'scheme-other-window)

;; Haskell mode
(setq exec-path (cons "~/.cabal/bin" exec-path))
(add-to-list 'load-path "~/.cabal/share/ghc-mod-1.11.0/")

(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
;(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))

(setq haskell-program-name "/usr/bin/ghci")

;; Egison mode
(autoload 'egison-mode "egison-mode" "Major mode for editing Egison code." t)
(setq auto-mode-alist
      (cons `("\\.egi$" . egison-mode) auto-mode-alist))


;; Marmalade setting
(require 'package)
(add-to-list 'package-archives
                 '("marmalade" .
                         "http://marmalade-repo.org/packages/"))
(package-initialize)
