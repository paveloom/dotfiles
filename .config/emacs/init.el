;; Set the default font
(set-face-attribute 'default nil
		    :family "JetBrains Mono Nerd Font"
		    :height 140
		    :weight 'normal)
		    :width 'normal

;; Save desktop and restore it on start
(desktop-save-mode 1)

;; Set the number of seconds for auto-saving the desktop
(setq-default desktop-auto-save-timeout 1)

;; Always read the locked desktop
(setq-default desktop-load-locked-desktop t)

;; Don't force offscreen frames to be onscreen when restoring the desktop
(setq-default desktop-restore-forces-onscreen nil)

;; Save minibuffer history
(savehist-mode 1)

;; Show the name of the character in ‘what-cursor-position’
(setq-default what-cursor-show-names t)

;; Backup files in one directory
(setq-default backup-directory-alist
	      `(("." . ,(file-name-concat user-emacs-directory "backup"))))

;; Truncate long lines by default
(setq-default truncate-lines t)

;; Don't show the scrollbar in the minibuffer
(set-window-scroll-bars (minibuffer-window) nil nil)

;; Scroll the display precisely, according to the turning of the mouse wheel
(pixel-scroll-precision-mode 1)
