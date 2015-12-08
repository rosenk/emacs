;;; init.el --- Simple config

;;; Commentary:

(require 'package) ;; You might already have this line

;;; Code:
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa.org/packages/") t)
(package-initialize) ;; You might already have this line

;; make sure the use-package package is installed
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant


;; load a default theme
(use-package zenburn-theme
  :ensure t
  :init
  (load-theme 'zenburn t))


;; frame
(use-package frame
  :ensure nil
  :config
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0)
  (column-number-mode 1)
  :bind ([f12] . menu-bar-mode))

(auto-save-mode 0)

;; guide-key
(use-package guide-key
  :ensure t
  :diminish guide-key-mode
  :init (guide-key-mode 1)
  :config
  (setq
   guide-key/guide-key-sequence '("C-x" "C-c" "C-h")
   guide-key/recursive-key-sequence-flag t
   guide-key/idle-delay 0.2))

;; neotree
(use-package neotree
  :ensure t
  :bind ([f8] . neotree-toggle))

;; helm-M-x
(use-package helm
  :ensure t
  :bind ("M-x" . helm-M-x)
  :config
  (setq helm-M-x-fuzzy-match t))

;; helm-themes
(use-package helm-themes
  :ensure t
  :bind ("C-x t" . helm-themes))

;; ido and flx-ido
(use-package ido
  :init (progn (ido-mode 1)
			   (ido-everywhere 1))
  :config
  (setq ido-enable-flex-matching t
		ido-use-faces nil))

(use-package flx-ido
  :ensure t
  :init (flx-ido-mode 1))

;; programming
(use-package linum
  :config
  (add-hook 'prog-mode-hook 'linum-mode))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'flycheck-mode))

(use-package haskell-mode
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation))

(use-package windmove
  :init (windmove-default-keybindings 'meta))

(use-package recentf
  :config
  (setq recentf-save-file "~/.emacs.d/.recentf"
		recentf-max-saved-items 1000)
  (recentf-mode))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  :config
  (progn
	(defadvice magit-status (around magit-fullscreen activate)
	  (window-configuration-to-register :magit-fullscreen)
	  ad-do-it
	  (delete-other-windows))
	(defun magit-quit-session ()
	  "Restores the previous window configuration and kills the magit buffer"
	  (interactive)
	  (kill-buffer)
	  (jump-to-register :magit-fullscreen))
	(bind-key "q" 'magit-quit-session magit-status-mode-map)))

(use-package ace-jump-mode
  :ensure t
  :bind ("C-a" . ace-jump-mode))

(use-package autorevert
  :init (global-auto-revert-mode 1))

(use-package hl-line
  :config
  (add-hook 'prog-mode-hook 'hl-line-mode))

(defun toggle-transparency ()
  "Toggle between transparent or opaque display."
  (interactive)
  ;; Define alpha if it's nil
  (if (eq (frame-parameter (selected-frame) 'alpha) nil)
	  (set-frame-parameter (selected-frame) 'alpha '(100 100)))
  ;; Do the actual toggle
  (if (/= (cadr (frame-parameter (selected-frame) 'alpha)) 100)
	  (set-frame-parameter (selected-frame) 'alpha '(100 100))
	(set-frame-parameter (selected-frame) 'alpha
						 (list 90 90))))

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  :bind ("<C-tab>" . projectile-find-other-file))

(use-package cider
  :ensure t)

(use-package rtags
  :ensure t)

(use-package cmake-ide
  :ensure t
  :config
  (cmake-ide-setup)
  :bind ([f9] . recompile))

(use-package indent
  :ensure nil
  :bind ("<backtab>" . indent-rigidly-left-to-tab-stop))


(setq auto-save-default nil)

(setq compilation-scroll-output t)
(fset 'yes-or-no-p 'y-or-n-p)

(delete-selection-mode)
(cua-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cmake-ide-rc-executable "~/dev/rtags/build/bin/rc")
 '(cmake-ide-rdm-executable "~/dev/rtags/build/bin/rdm")
 '(cursor-type (quote bar))
 '(inhibit-startup-screen t)
 '(rtags-path "~/dev/rtags/build/bin/")
 '(safe-local-variable-values
   (quote
	((cmake-ide-rc-executable . "~/dev/rtags/build/bin/rc")
	 (cmake-ide-rdm-executable . "~/dev/rtags/build/bin/rdm")
	 (cmake-ide-dir . "/home/rosen/projects/g2s/buildninja"))))
 '(tab-width 4)
 '(transient-mark-mode nil)
 '(truncate-lines t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)
;;; init.el ends here
