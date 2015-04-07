;; OSX tweaks

(normal-erase-is-backspace-mode t)


(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse    
(setq scroll-step 1) ;; keyboard scroll one line at a time
;; (setq-default scroll-conservatively 1000) ;scroll 1 line at a time
;; (setq scroll-step 1)                      ;scroll 1 line at a time
(setq font-lock-maximum-decoration t)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [del] 'delete-char)

;; The hyper key (command) is meta
(setq ns-function-modifier 'hyper)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(message "Command is now bound to META and Option is bound to SUPER.")

; Fix iedit bug in Mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; color is wrong for main-line or powerline
(if domacs/no-srgb-please
    (setq ns-use-srgb-colorspace nil)
    ()
  )




(provide 'osx-tweaks)
