;; Load user interface settings



;; font
;;(set-default-font "Source Code Pro 13")
(setq default-frame-alist '((font . "Source Code Pro 13")))

;; color theme
;;(load-theme 'zenburn t)
(load-theme 'domacs-color t)

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
;;(setq sml/theme 'dark)
;;(sml/setup)
;; power-line settings
(require 'powerline)
(powerline-default-theme)
(setq powerline-default-separator "zigzag")
;;(require 'main-line)
;;(setq main-line-separator-style "rounded")
(defvar domacs/no-srgb-please t ;; <- put t to disable srgb in osx-tweaks
  "Please don't use the srgb option on OSX, because it breaks powerline and main-line")

;; Who uses abbrev-mode ???
(abbrev-mode 0)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; winner mode to undo window configurations
(winner-mode +1)

;; line number mode at fringe
;;(global-nlinum-mode)

;; delete the selection with a keypress
(delete-selection-mode t)

;; save backups in a temporal directory, not in my filesystem
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; uniquify: manage buffers with the same name properly
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward) ;; use /dir1/dir2/filename style
(setq uniquify-separator "/")              ;; separate with /
(setq uniquify-after-kill-buffer-p)        ;; rename buffers when another is closed
(setq uniquify-ignore-buffers-re "^\\*")   ;; ignore special buffers

;; diminish keeps the modeline tidy
(require 'diminish)
;;(diminish auto-complete-mode "Ⓐ")
;;(diminish cc-mode "Ⓒ")
(eval-after-load "yasnippet" '(diminish 'yas-minor-mode " Ⓨ"))
(eval-after-load "flycheck" '(diminish 'flycheck-mode " Ⓕ"))
(eval-after-load "auto-complete" '(diminish 'auto-complete-mode " Ⓐ"))
;;(eval-after-load "cc-mode" '(diminish 'c-mode " Ⓒ")) ;; does not work!
(eval-after-load "abbrev" '(diminish 'abbrev-mode))
;;(eval-after-load "python" '(diminish 'inferior-python-mode " ♘"))
(eval-after-load "compile" '(diminish 'compilation-shell-minor-mode " ♞"))

;; major modes cannot be dimished with diminish, we need to change the
;; name in their respective hooks
;; example: emacs-lisp:
(add-hook 'emacs-lisp-mode-hook 
          (lambda()
            (setq mode-name " ∑")))
;; (add-hook 'compilation-mode-hook
;;           (lambda()
;;             (setq mode-name " ★")))
(add-hook 'inferior-python-mode-hook
          (lambda()
            (setq mode-name " (★π)")))


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
(eval-after-load "projectile" '(diminish 'projectile-mode " ☣"))
;;(diminish "projectile-mode" "Ⓟ")
;;(diminish 'projectile-mode "Prjl")

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
(eval-after-load "guide-key" '(diminish 'guide-key-mode))

;; purpose-mode: automatic window configuration
(require 'window-purpose)
(purpose-mode 1)
(add-to-list 'purpose-user-mode-purposes '(python-mode . py))
(add-to-list 'purpose-user-mode-purposes '(inferior-python-mode . py-repl))
(add-to-list 'purpose-user-mode-purposes '(c++-mode . cpp))
(add-to-list 'purpose-user-mode-purposes '(c-header-mode . h))
(add-to-list 'purpose-user-mode-purposes '(compilation-mode . compilation))
(purpose-compile-user-configuration)
(eval-after-load "window-purpose" '(diminish 'purpose-mode " ⓦ"))


;; git-gutter-fringe. I finally decided to drop the linum / nlinum and
;; put the fringe to good use
(require 'git-gutter-fringe)
(eval-after-load "git-gutter" '(diminish 'git-gutter-mode " Ⓖ"))

;; anzu
(require 'anzu)
(global-anzu-mode 1)

(provide 'ui-config)
