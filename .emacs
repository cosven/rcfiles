(require 'package)
(add-to-list 'package-archives '("melpa" . "http://stable.melpa.org/packages/"))

;; 加载已经安装的包，这样子，之后 requrie 一个包就可以让该包生效
(package-initialize)


(defun require-or-install-pkg (pkg)
  (unless (package-installed-p pkg)
    (package-refresh-contents)  ;; 重要
    (package-install pkg)))

;; 安装一些包
(require-or-install-pkg 'ace-jump-mode)
(require-or-install-pkg 'ivy)


;;
;; 基础的设置（与第三方 package 无关的配置）
;;
(toggle-scroll-bar -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(xterm-mouse-mode 1)

;; 三方库相关配置

;; -------------
;; ace-jump-mode
;; -------------
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; ------------
;; ivy 相关配置
;; ------------

(ivy-mode 1)
