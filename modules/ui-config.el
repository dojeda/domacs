;; Load user interface settings

;; color theme
(load-theme 'zenburn t)

;; no toolbar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; menubar
(menu-bar-mode +1)

;; no blinking cursor
(blink-cursor-mode -1)

;; disable startup screen
(setq inhibit-startup-screen t)

;; ;; nice scrolling (currently testing if I really want this)
;; (setq scroll-margin 0
;;       scroll-conservatively 100000
;;       scroll-preserve-screen-position 1)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; winner mode to undo window configurations
(winner-mode +1)

;; line number mode at fringe
(global-nlinum-mode)

;; delete the selection with a keypress
(delete-selection-mode t)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; diminish keeps the modeline tidy
(require 'diminish)

;; saveplace remembers your location in a file when saving files
(require 'saveplace)
(setq save-place-file (expand-file-name "saveplace" domacs/savefile-dir))
;; activate it for all buffers
(setq-default save-place t)

;; show-paren-mode: subtle highlighting of matching parens (global-mode)
(require 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode +1)

;; highlight the current line
(global-hl-line-mode +1)

;; show modifications
(require 'volatile-highlights)
(volatile-highlights-mode t)
(diminish 'volatile-highlights-mode)

;; projectile
(require 'projectile)
(setq projectile-cache-file (expand-file-name  "projectile.cache" domacs/savefile-dir))
(projectile-global-mode t)
(diminish 'projectile-mode "Prjl")

(provide 'ui-config)
