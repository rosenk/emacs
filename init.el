(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
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
(load-theme 'misterioso)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(global-set-key [f12] 'menu-bar-mode)

;; start frames maximized
(toggle-frame-maximized)

(global-auto-revert-mode t)

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
  :bind ("M-x" . helm-M-x))

;; helm-themes
(use-package helm-themes
  :ensure t
  :bind ("C-x t" . helm-themes))

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; c-c++
(add-hook 'c-mode-hook 'linum-mode) 
(add-hook 'c++-mode-hook 'linum-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook 'flycheck-mode)


(use-package windmove
  :init (windmove-default-keybindings 'meta))

(use-package recentf
  :config (setq recentf-save-file "~/.emacs.d/.recentf"))

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
