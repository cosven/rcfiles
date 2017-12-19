;;; package --- Summary
;;; Commentary:
;; Emacs config created by cosven

;;; Code:
;;
;; 基础的设置（与第三方 package 无关的配置）
;;

;; 非常不好用的自动缩进 mode
;; (add-hook 'after-change-major-mode-hook
;;           (lambda()
;;             (when (not (derived-mode-p 'lisp-mode 'python-mode))
;;               (electric-indent-mode -1))))
(add-hook 'eww-mode-hook
          (lambda()
            ;; 让背景看起来更正常
            (setq-default shr-color-visible-luminance-min 70)
            (setq show-trailing-whitespace nil)))
(add-hook 'term-char-mode
          (lambda ()
            (setq show-trailing-whitespace nil)))
(add-hook 'term-line-mode
          (lambda ()
            (setq show-trailing-whitespace nil)))

(setq-default cursor-type 'box)
(set-default 'truncate-lines t)
(load-theme 'manoj-dark)
(setq-default eww-search-prefix "https://www.google.com/search?q=")
(setq-default python-shell-completion-native-enable nil)
(setq-default help-window-select t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode -1)
(xterm-mouse-mode 1)
(setq vc-follow-symlinks t)
(setq custom-file "~/.emacs-custom.el")
(setq-default org-agenda-files '("~/coding/cosven.github.io/life"))
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(setq-default c-default-style "linux"
              c-basic-offset 4)
;; (add-to-list 'default-frame-alist '(width . 80))
(global-set-key (kbd "C-c e")
		(lambda () (interactive) (find-file user-init-file)))
(set-face-attribute 'default nil :font "Monaco")
(set-frame-font "Monaco 13" nil t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'delete-trailing-lines)

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

(require 'package)
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

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
;; (require-or-install-pkg 'company)
;; (require-or-install-pkg 'auto-complete)
(require-or-install-pkg 'ace-window)
(require-or-install-pkg 'web-mode)
(require-or-install-pkg 'exec-path-from-shell)
(require-or-install-pkg 'goto-last-change)
(require-or-install-pkg 'multiple-cursors)
(require-or-install-pkg 'color-theme-solarized)
(require-or-install-pkg 'undo-tree)
;; (require-or-install-pkg 'git-gutter-fringe)
;; (require-or-install-pkg 'nyan-mode)
(require-or-install-pkg 'markdown-mode)
(require-or-install-pkg 'elpy)
(require-or-install-pkg 'diminish)
(require-or-install-pkg 'groovy-mode)
;; (require-or-install-pkg 'evil)
;; (require-or-install-pkg 'xah-fly-keys)
(require-or-install-pkg 'page-break-lines)

;; 达不到保存 window layout 的效果
;;(require-or-install-pkg 'persp-mode)
(require-or-install-pkg 'perspeen)
(require-or-install-pkg 'which-key)

(when (>= emacs-major-version 25)
  (require-or-install-pkg 'fill-column-indicator)
  (fci-mode 1))

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
(setq-default ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)

;;(global-set-key (kbd "C-c v s") 'ivy-switch-view)
;;(global-set-key (kbd "C-c v c") 'ivy-push-view)
;;(global-set-key (kbd "C-c v d") 'ivy-pop-view)

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

; (add-hook 'after-init-hook 'global-company-mode)
(setq-default company-idle-delay 1.5)
;; ----------
;; projectile
;; ----------

(counsel-projectile-on)
(projectile-mode)
(setq-default projectile-enable-caching t)

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

(global-set-key (kbd "\C-c ;") 'goto-last-change)


;; ----------------
;; multiple-cursors
;; ----------------

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;; ---------
;; undo-tree
;; ---------

(global-undo-tree-mode)

;; -----------------
;; git-gutter-fringe
;; -----------------

;; (global-git-gutter-mode)

;; --------
;; diminish
;; --------

(diminish 'projectile-mode "PRJ")
(eval-after-load 'company
  '(diminish 'company-mode "CMP"))
(diminish 'undo-tree-mode)

;; for major mode
(add-hook 'python-mode
          (lambda()
            (setq mode-name "Py")))

;;; ---
;;; org
;;; ---

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; ------
;; groovy
;; ------

(add-hook 'groovy-mode-hook
          (lambda ()
            (electric-indent-local-mode -1)
            (setq tab-stop-list [2, 4, 6, 8, 10])
            (setq tab-width 2)))

;; -------------
;; auto-complete
;; -------------
;; (ac-config-default)

;; ----
;; elpy
;; ----
(elpy-enable)
(add-hook 'elpy-mode-hook
 (lambda ()
   (highlight-indentation-mode -1)))


(defun my-local-pytest-runner (top file module test)
  "Test the project using the local py.test test runner.

This requires the pytest in ./bin directory"
  (interactive (elpy-test-at-point))
  (apply #'elpy-test-run top '("bin/py.test")))
(put 'my-local-pytest-runner 'elpy-test-runner-p t)


;; -----
;; slack
;; -----

;; which-key

(which-key-mode)

;; perspeen


(perspeen-mode)
;; (setq-default perspeen-use-tab t)
;; (setq-default perspeen-keymap-prefix (kbd "C-c w"))

;; ----------------------
;; every thing about evil
;; ----------------------
;; (evil-mode 1)
;; (add-hook 'evil-mode-hook
;;           (lambda ()
;;             (modify-syntax-entry ?_ "w")))
;; (setq-default evil-insert-state-cursor 'box)

(load custom-file)
(provide '.emacs)
;;; .emacs ends here
