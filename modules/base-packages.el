;; Load package management
(require 'package)
(require 'cl)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'package-archives
;;             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)


;; Required packages
(defvar domacs/required-packages
  '(zenburn-theme         ;; color theme
    color-theme-solarized ;; color theme
    magit         ;; great git package
    git-messenger ;; show commit message at point
    git-timemachine ;; browse git commits
    yasnippet     ;; snippets
    ;;nlinum        ;; line number package that uses the fringe
    projectile    ;; project management mode
    diminish      ;; avoid clutter in modeline
    ;;delight       ;; avoid clutter in modeline
    ;;smart-mode-line ;; another mode line theme
    ;;powerline       ;; another mode line theme
    ;;main-line     ;; another mode line theme
    volatile-highlights ;; highlight some buffer modifications
    highlight     ;; highlighy symbols at point
    helm          ;; command narrowing on steroids
    helm-projectile ;; helm and projectile integration
    helm-swoop    ;; filter search and edit in places with helm
    auctex        ;; latex support: auctex
    auctex-latexmk;; latexmk with auctex
    org           ;; org-mode
    ;; ido           ;; menu for changes around buffers and files
    ;; flx           ;; fuzzy matching
    ;; flx-ido       ;; flx and ido
    ;; smex          ;; fuxxy auto completion for M-x
    ;; ido-vertical-mode ;; vertical ido
    ;; ido-ubiquitous  ;; ???
    multiple-cursors ;; multiple cursors
    iedit         ;; modify multiple regions (useful for refactoring)
    auto-complete ;; auto complete
    auto-complete-clang ;; clang+auto complete
    flycheck      ;; on-the-fly syntax checker
    cpputils-cmake;; help auto-complete configure itself with cmake
    ;;guide-key     ;; help for complicated key bindings
    which-key     ;; better help and exploration of complicated key bindings
    cmake-mode    ;; cmake
    jedi          ;; python completion tool
    elpy          ;; python IDE-like tools
    ;;ack-and-a-half;; grep-like search for programmers
    matlab-mode   ;; matlab mode
    window-purpose ;; window configuration with purposes
    ace-jump-mode ;; quick jumps
    ;;idomenu       ;; TESTING: jumps to symbol
    expand-region ;; expand selection by semantic units (semantics as in the meaning not the mode, you silly)
    git-gutter-fringe ;; fringe with git information
    anzu          ;; show number of matches when searching
    ;;svg-mode-line-themes ;; svg
    rainbow-mode  ;; #123456 text as color
    json-mode     ;; json
    ess           ;; Emacs + R (statistics)
    )
  "A list of packages installed at launch")


;; function that checks if all packages are installed
(defun packages-installed-p ()
  (loop for p in domacs/required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; function that installs missing packages
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message " done.")
  ; install the missing packages
  (dolist (p domacs/required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'base-packages)
