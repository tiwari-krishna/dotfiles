;adding Melpha repos
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-always-ensure t)

; setting vim keybinds
(use-package evil)
(require 'evil)
(evil-mode)
(evil-set-undo-system 'undo-redo)

;adding gruvbox theme
(use-package doom-themes)
(load-theme 'doom-gruvbox t)

;removing Menubar scrollbar toolbar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode 1)
(delete-selection-mode t)
;(show-paran-mode 1)

;Remove the annoing ring sound
(setq ring-bell-function 'ignore)

;Rainbow Delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;adding the seperator between line number
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(column-number-mode)

; ESC quits prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(95 95))
(add-to-list 'default-frame-alist '(alpha 95 95))

; open emacs in empty buffer
;(setq initial-buffer-choice 'xah-new-empty-buffer)
;(setq initial-buffer-choice t)
;(setq inhibit-startup-screen t)
;(setq inhibit-startup-echo-area-message "Whatever")
;(setq inhibit-startup-message t) 
(set-fringe-mode 5)
;(setq initial-scratch-message nil)

;setting fonts
(set-face-attribute 'default nil :font "JetBrains Mono" :height 105)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("835868dcd17131ba8b9619d14c67c127aa18b90a82438c8613586331129dda63" "c4063322b5011829f7fdd7509979b5823e8eea2abf1fe5572ec4b7af1dd78519" "1d5e33500bc9548f800f9e248b57d1b2a9ecde79cb40c0b1398dec51ee820daf" "da186cce19b5aed3f6a2316845583dbee76aea9255ea0da857d1c058ff003546" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" default))
 '(large-file-warning-threshold 100000000)
 '(package-selected-packages
   '(doom-themes rainbow-delimiters ivy gcmh vterm gnu-elpa-keyring-update evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(recentf-mode 1)

;Enabling the dashboard
;(use-package dashboard
;  :ensure t
;  :config
;  (dashboard-setup-startup-hook))

;(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(use-package general
  :config
  (general-evil-setup t))

;Eshell
(use-package vterm)
(setq shell-file-name "/bin/bash"
      vterm-max-scrollback 5000)

;; Adding ivy-mode
(use-package ivy
  :config
  (ivy-mode))

;make no backup files
(setq make-backup-files nil)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
		vterm-mode-hook
                shell-mode-hook
	        treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 10)))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

 ;which key
 (use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))
