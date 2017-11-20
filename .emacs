;;
;; 基础的设置（与第三方 package 无关的配置）
;;
(toggle-scroll-bar -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(xterm-mouse-mode 1)
(setq vc-follow-symlinks t)


(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; 加载已经安装的包，这样子，之后 requrie 一个包就可以让该包生效
(package-initialize)

;; ----------------
;; 自己写的一些函数
;; ----------------
(defun require-or-install-pkg (pkg)
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
<<<<<<< Updated upstream
(require-or-install-pkg 'ace-window)

=======
(require-or-install-pkg 'exec-path-from-shell)
;;
;; 基础的设置（与第三方 package 无关的配置）
;;
(toggle-scroll-bar -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(xterm-mouse-mode 1)
(setq vc-follow-symlinks t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
>>>>>>> Stashed changes

;; 三方库相关配置

;; -------------
;; ace-jump-mode
;; -------------
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; ------------
;; ivy 相关配置
;; ------------


;; 一些好用的快捷键
;; C-M-n (ivy-next-line-and-call)

(ivy-mode 1)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-c f") 'counsel-git-grep)

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
