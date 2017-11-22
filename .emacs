;;; package --- Summary
;;; Commentary:
;; Emacs config created by cosven

;;; Code:
;;
;; 基础的设置（与第三方 package 无关的配置）
;;
(toggle-scroll-bar -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(xterm-mouse-mode 1)
(setq vc-follow-symlinks t)
(setq-default indent-tabs-mode nil)
(global-set-key (kbd "C-c e")
		(lambda () (interactive) (find-file user-init-file)))
(set-face-attribute 'default nil :font "Monaco")
(set-frame-font "Monaco" nil t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; 加载已经安装的包，这样子，之后 requrie 一个包就可以让该包生效
(package-initialize)

;; ----------------
;; 自己写的一些函数
;; ----------------
(defun require-or-install-pkg (pkg)
  "PKG is a package name."
  (unless (package-installed-p pkg)
    (package-refresh-contents)  ;; 重要
    (package-install pkg)))

;; 安装一些包
(require-or-install-pkg 'ace-jump-mode)
(require-or-install-pkg 'ivy)  ;; ido replacement
(require-or-install-pkg 'swiper)  ;; isearch replacement
(require-or-install-pkg 'projectile)  ;; project management
(require-or-install-pkg 'magit)  ;; git integration
(require-or-install-pkg 'flycheck)  ;; syntax checking
(require-or-install-pkg 'neotree)
(require-or-install-pkg 'counsel-projectile)
(require-or-install-pkg 'org)
(require-or-install-pkg 'company)
(require-or-install-pkg 'ace-window)
(require-or-install-pkg 'web-mode)
(require-or-install-pkg 'exec-path-from-shell)
(require-or-install-pkg 'goto-last-change)

;; 三方库相关配置

;; -------------
;; ace-jump-mode
;; -------------
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; ------------
;; ivy 相关配置
;; ------------

;; 一些好用的快捷键
;; 1. C-M-n (ivy-next-line-and-call)

(ivy-mode 1)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)

;;
(global-set-key (kbd "C-c g") 'counsel-git-grep)

(defun grep-cur-word ()
  "Grep word under cursor in whole project."
  (interactive)
  (counsel-git-grep nil (thing-at-point 'word)))

(global-set-key (kbd "C-c f") 'grep-cur-word)

;; ------------
;; company-mode
;; ------------

(add-hook 'after-init-hook 'global-company-mode)

;; ----------
;; projectile
;; ----------

(counsel-projectile-on)
(projectile-mode)



;; --------
;; flycheck
;; --------

;; 常用快捷键
;; 1. C-x ` (jump to next error)

(global-flycheck-mode)

;; ----------
;; ace-window
;; ----------
(global-set-key (kbd "M-p") 'ace-window)


;; --------------------
;; exec-path-from-shell
;; --------------------
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; --------
;; web-mode
;; --------
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(setq-default web-mode-enable-auto-indentation nil)
(setq-default web-mode-code-indent-offset 2)

(add-hook 'web-mode-hook
          (lambda ()
            (electric-indent-local-mode -1)
            (setq tab-stop-list [2, 4, 6, 8, 10])
            (setq tab-width 2)))

;; ----------------
;; goto-last-chagne
;; ----------------

(global-set-key (kbd "\C-c ,") 'goto-last-change)

(provide '.emacs)
;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (goto-last-change web-mode neotree magit flycheck exec-path-from-shell counsel-projectile company ace-window ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
