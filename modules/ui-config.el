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
;; smart mode line settings
(setq sml/theme 'dark)
(sml/setup)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; winner mode to undo window configurations
(winner-mode +1)

;; line number mode at fringe
(global-nlinum-mode)

;; delete the selection with a keypress
(delete-selection-mode t)

;; save backups in a temporal directory, not in my filesystem
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

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
(setq projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" domacs/savefile-dir))
(projectile-global-mode t)
(diminish 'projectile-mode "Prjl")

;; helm
;;(helm-mode) ;; not sure how this works yet: it uses another buffer to complete commands.

;; ido
(ido-mode t)
(setq ido-enable-prefix nil          ;; match all string, not only the prefix
      ido-enable-flex-matching t     ;; flexible matching: if there is no match, search containing characters
      ido-create-new-buffer 'always  ;; create new buffer if no match is found
      ido-use-filename-at-point nil  ;; do not try to guess using current point
      ;;ido-max-window-height 10
      ido-save-directory-list-file (expand-file-name "ido.last" domacs/savefile-dir)
      ido-auto-merge-work-directories-length -1 ;; ???
      ido-default-file-method 'selected-window ;; use same window to visit a file
      ;; ido-ignore-extensions t
      ido-file-extensions-order '(".org" ".c" ".cpp" ".c" ".h" ".txt"))
(flx-ido-mode 1)
(setq ido-use-faces nil)
(ido-vertical-mode 1)
(ido-ubiquitous-mode 1)

;; guide-key
(setq guide-key/guide-key-sequence '("C-x r" ;; rectangles
                                     "C-x 4" ;; ? ido ?
                                     "C-x 5" ;; frames
                                     "C-c p" ;; projectile
                                     ))
(guide-key-mode 1)

(provide 'ui-config)
