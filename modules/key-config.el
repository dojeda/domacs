;; ;; smex
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; ;; the old M-x.
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; shift-arrow to move across buffers
(require 'windmove)
(windmove-default-keybindings)

;; ispell
(global-set-key [f4] 'ispell-word)

;; comment
;; (global-set-key [f13] 'comment-region)
;; (global-set-key (kbd "S-<f13>") 'uncomment-region)
;; (when (string= system-name "malboro-vbox")
  ;; (progn
(global-set-key [f7] 'comment-region)
(global-set-key (kbd "S-<f7>") 'uncomment-region)
;; ))

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

;; Magit keys
(global-set-key (kbd "C-x g") 'magit-status)
;; git messenger
(global-set-key (kbd "C-x v p") 'git-messenger:popup-message)

;; IBuffer for easier buffer switching with C-x C-b
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Ace-jump mode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; Expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; quick jump
(require 'quick-jump)
;; TODO: remap this to my new keyboard
;; (global-set-key [f16] 'quick-jump-go-back)
;; (global-set-key [f17] 'quick-jump-go-forward)
;; (global-set-key [f18] 'quick-jump-clear-all-marker)
;; (global-set-key [f19] 'quick-jump-push-marker)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)


;; bindings using bind-key
(require 'bind-key)
(bind-keys
 :map smartparens-mode-map
 ("C-` <right>" . sp-forward-slurp-sexp)
 ("C-` S-<right>" . sp-forward-barf-sexp)
 ("C-` <left>"  . sp-backward-slurp-sexp)
 ("C-` S-<left>"  . sp-backward-barf-sexp)
 )

(provide 'key-config)
