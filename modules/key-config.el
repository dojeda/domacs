;; shift-arrow to move across buffers 
(require 'windmove)
(windmove-default-keybindings)

;; f7 to comment
(global-set-key [f7] 'comment-region)
(global-set-key (kbd "S-<f7>") 'uncomment-region)

(provide 'key-config)
