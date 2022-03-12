;adding Melpha repos
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
				 ("org" . "https://orgmode.org/elpa/")
				 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

; setting vim keybinds
(require 'evil)
(evil-mode 1)

;(use-package all-the-icons)

;adding gruvbox theme
(load-theme 'gruvbox-dark-medium t)

;removing Menubar scrollbar toolbar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode 1)
;(show-paran-mode 1)

;Remove the annoing ring sound
(setq ring-bell-function 'ignore)

;coding system
(set-default-coding-systems 'utf-8)
(customize-set-variable 'large-file-warning-threshold 100000000) ; warning above 100M

;adding the seperator between line number
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(95 95))
(add-to-list 'default-frame-alist '(alpha 95 95))

; open emacs in empty buffer
;(setq initial-buffer-choice 'xah-new-empty-buffer)
;(setq initial-buffer-choice t)
;(setq inhibit-startup-screen t)
;(setq inhibit-startup-echo-area-message "Whatever")
(setq inhibit-startup-message t) 
(set-fringe-mode 5)
;(setq initial-scratch-message nil)

;setting fonts
(set-face-attribute 'default nil :font "mononoki Nerd Font" :height 110)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-buffer-modification-icon nil)
 '(doom-modeline-buffer-state-icon nil)
 '(doom-modeline-height 20)
 '(doom-modeline-icon nil)
 '(doom-modeline-major-mode-color-icon nil)
 '(doom-modeline-major-mode-icon nil)
 '(doom-modeline-modal-icon nil)
 '(doom-modeline-mu4e nil)
 '(large-file-warning-threshold 100000000)
 '(package-selected-packages
   '(magit pdf-tools swiper ivy doom-modeline smart-tabs-mode all-the-icons doom-themes sxiv mpv eshell-autojump eshell-syntax-highlighting exwm-x cl-format chess dired-open dired-icon dir-treeview exwm emoji-display unicode-fonts emoji-fontset xclip gruvbox-theme gnu-elpa-keyring-update evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(recentf-mode 1)

;My rss feed reader
(setq elfeed-feeds
      '("https://planet.emacslife.com/atom.xml
         https://archlinux.org/feeds/news/
         https://artixlinux.org/feed.php
         https://lukesmith.xyz/videos
         https://lukesmith.xyz/rss.xml
         https://odysee.com/$/rss/@Luke/70
         https://notrelated.xyz/rss
         https://www.debian.org/News/weekly/dwn.en.rdf"))

(require 'doom-modeline)
(doom-modeline-mode 1)

(setq doom-modeline-height 1)
(set-face-attribute 'mode-line nil :family "Noto Sans" :height 110)
(set-face-attribute 'mode-line-inactive nil :family "Noto Sans" :height 110)

(ivy-mode 1)
