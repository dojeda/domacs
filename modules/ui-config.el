;; Load user interface settings

;; whitespce management
(require 'whitespace)
;;(global-whitespace-mode t)
;;(global-whitespace-cleanup-mode t)
;;(add-hook 'before-save-hook 'whitespace-cleanup)

;; Fix whitespace in popups
(defvar my-prev-whitespace-mode nil)
(make-variable-buffer-local 'my-prev-whitespace-mode)

(defadvice popup-draw (before my-turn-off-whitespace activate compile)
  "Turn off whitespace mode before showing autocomplete box"
  (if whitespace-mode
      (progn
        (setq my-prev-whitespace-mode t)
        (whitespace-mode -1)
        (setq my-prev-whitespace-mode t))))

(defadvice popup-delete (after my-restore-whitespace activate compile)
  "Restore previous whitespace mode when deleting autocomplete box"
  (if my-prev-whitespace-mode
      (progn
        (whitespace-mode 1)
        (setq my-prev-whitespace-mode nil))))

;; Fix Company mode whitespace in popups
(defvar domacs/company-prev-whitespace-mode nil)
(make-variable-buffer-local 'domacs/company-prev-whitespace-mode)
(make-variable-buffer-local 'domacs/company-prev-fci-mode)
(defun pre-popup-draw ()
  "Turn off whitespace mode before showing company complete box through elpy-company-backend"
  (progn
    (if whitespace-mode
        (progn
          (setq domacs/company-prev-whitespace-mode t)
          (whitespace-mode -1)))
    (if fci-mode
        (progn
          (setq domacs/company-prev-fci-mode t)
          (fci-mode -1)))))

(defun post-popup-draw ()
  "Restore previous whitespace mode after showing company complete box through elpy-company-backend"
  (progn
    (if domacs/company-prev-whitespace-mode
        (progn
          (whitespace-mode 1)
          (setq domacs/company-prev-whitespace-mode nil)))
    (if domacs/company-prev-fci-mode
        (progn
          (fci-mode 1)
          (setq domacs/company-prev-fci-mode nil)))))
(advice-add 'company-pseudo-tooltip-unhide :before #'pre-popup-draw)
(advice-add 'company-pseudo-tooltip-hide :after #'post-popup-draw)


;; font
;; (set-default-font "DejaVu Sans Mono 12")
;; (setq default-frame-alist '((font . "DejaVu Sans Mono 12")))
;;(set-face-attribute 'mode-line nil  :height 80)
;; (let ((bg (face-attribute 'default :background)))
;;   (set-face-attribute 'header-line nil  :height 120 :background bg))


;; color theme
;;(load-theme 'zenburn t)
;; (if (eq system-type 'windows-nt)
;;   (load-theme 'zenburn t))
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
(setq scroll-margin 4 ; number of lines shown around scrolling, for example when isearch finds a hit
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
              scroll-down-aggressively 0.01)
(scroll-bar-mode -1)
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
;;(require 'powerline)
;;(powerline-default-theme)
;;(setq powerline-default-separator "zigzag")
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
(setq uniquify-after-kill-buffer-p t)        ;; rename buffers when another is closed
(setq uniquify-ignore-buffers-re "^\\*")   ;; ignore special buffers

;; diminish keeps the modeline tidy
(require 'diminish)
(eval-after-load "yasnippet" '(diminish 'yas-minor-mode " Y"))
(eval-after-load "flycheck" '(diminish 'flycheck-mode " F"))
(eval-after-load "auto-complete" '(diminish 'auto-complete-mode " ac"))
(eval-after-load "abbrev" '(diminish 'abbrev-mode))
;;(eval-after-load "compile" '(diminish 'compilation-shell-minor-mode " ♞"))

;; major modes cannot be diminished with diminish, we need to change the
;; name in their respective hooks
;; example: emacs-lisp:
(add-hook 'emacs-lisp-mode-hook
           (lambda()
             (setq mode-name " EL")))
;; (add-hook 'compilation-mode-hook
;;           (lambda()
;;             (setq mode-name " ★")))
(add-hook 'inferior-python-mode-hook
          (lambda()
            (setq mode-name " Py")))

;; ;; delight keeps the modeline tidy
;; (require 'delight)
;; (delight '((yas-minor-mode " YYY")))


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
(eval-after-load "projectile" '(diminish 'projectile-mode " P"))
;;(diminish "projectile-mode" "Ⓟ")
;;(diminish 'projectile-mode "Prjl")

;; helm
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
;; DOMACS: this is why I have to do this key configuration here and
;; not in key-config.el (see comments above)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;; (when (executable-find "curl")
;;   (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x

(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C-x b") 'helm-mini)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(helm-autoresize-mode t)

(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; ;; ido
;; (ido-mode t)
;; (setq ido-enable-prefix nil          ;; match all string, not only the prefix
;;       ido-enable-flex-matching t     ;; flexible matching: if there is no match, search containing characters
;;       ido-create-new-buffer 'always  ;; create new buffer if no match is found
;;       ido-use-filename-at-point nil  ;; do not try to guess using current point
;;       ;;ido-max-window-height 10
;;       ido-save-directory-list-file (expand-file-name "ido.last" domacs/savefile-dir)
;;       ido-auto-merge-work-directories-length -1 ;; ???
;;       ido-default-file-method 'selected-window ;; use same window to visit a file
;;       ;; ido-ignore-extensions t
;;       ido-file-extensions-order '(".org" ".c" ".cpp" ".c" ".h" ".txt"))
;; (flx-ido-mode 1)
;; (setq ido-use-faces nil)
;; (ido-vertical-mode 1)
;; (setq ido-vertical-define-keys 'C-n-and-C-p-only)
;; (ido-ubiquitous-mode 1)

;; guide-key
;; (setq guide-key/guide-key-sequence '("C-x r" ;; rectangles
;;                                      ;;"C-x 4" ;; ? ido ?
;;                                      "C-c h" ;; helm
;;                                      "C-x 5" ;; frames
;;                                      "C-c p" ;; projectile
;;                                      ))
;; (guide-key-mode 1)
;; (eval-after-load "guide-key" '(diminish 'guide-key-mode))

;; ;; purpose-mode: automatic window configuration
;; (require 'window-purpose)
;; (purpose-mode 1)
;; (add-to-list 'purpose-user-mode-purposes '(python-mode . py))
;; (add-to-list 'purpose-user-mode-purposes '(inferior-python-mode . py-repl))
;; (add-to-list 'purpose-user-mode-purposes '(rst-mode . ReST))
;; (add-to-list 'purpose-user-mode-purposes '(c++-mode . cpp))
;; (add-to-list 'purpose-user-mode-purposes '(c-header-mode . h))
;; (add-to-list 'purpose-user-mode-purposes '(compilation-mode . compilation))
;; (add-to-list 'purpose-user-mode-purposes '(inferior-ess-mode . Rshell))
;; (add-to-list 'purpose-user-mode-purposes '(ess-help-mode . Rhelp))
;; (add-to-list 'purpose-user-mode-purposes '(ess-mode . R))
;; (purpose-compile-user-configuration)
;; (eval-after-load "window-purpose" '(diminish 'purpose-mode " ⓦ"))


;; git-gutter-fringe. I finally decided to drop the linum / nlinum and
;; put the fringe to good use
(require 'git-gutter-fringe)
(eval-after-load "git-gutter" '(diminish 'git-gutter-mode " G"))

;; anzu
(require 'anzu)
(global-anzu-mode 1)
(eval-after-load "anzu" '(diminish 'anzu-mode))

(eval-after-load "magit" '(diminish 'magit-auto-revert-mode))

;; ;; ocodo: nice svg-modes
;; (require 'ocodo-svg-modelines)
;; (ocodo-svg-modelines-init)
;; (smt/set-theme 'ocodo-mesh-grass-smt)


(require 'which-key)
(which-key-mode)
(eval-after-load "which-key" '(diminish 'which-key-mode " W"))

;; disable/enable weird emacs configuration
(put 'narrow-to-region 'disabled nil)

;; Company colors
(require 'color)

(let ((bg (face-attribute 'default :background)))
  (custom-set-faces
   `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
   `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
   `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
   `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
   `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))

;; ;; TEST: confluence
;; (require 'confluence)
;; (setq confluence-url "https://jira.mensiatech.com/confluence/rpc/xmlrpc")

(provide 'ui-config)
