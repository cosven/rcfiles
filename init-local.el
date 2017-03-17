;;; package --- my configuration
;;; Code:

(require 'neotree)
(global-set-key [f2] 'neotree-toggle)

(setq-default custom-enabled-themes '(monoj-dark))

(add-to-list 'default-frame-alist
             '(font . "Monaco-13"))

(provide 'init-local)
