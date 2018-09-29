;;; package --- Summary
;;; Commentary:
;; Emacs config created by cosven
;;; Code:
;;
;;
;; ----------------
;; 基础的设置（与第三方 package 无关的配置）
;; ----------------
(defun require-or-install-pkg (pkg)
  "PKG is a package name."
  (unless (package-installed-p pkg)
    (package-refresh-contents)  ;; 重要
    (package-install pkg))
  (require pkg))

(defun init-ui-look ()
  "Init Emacs look."
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  ;; (global-linum-mode -1)
  (fringe-mode -1)
  (if (display-graphic-p)
      (progn
        (menu-bar-mode 1))
    ;; hide org string since we show it on tmux status line
    (setq-default org-mode-line-string nil))
  (menu-bar-mode -1)
  (cond ((eq system-type 'darwin)
         (set-face-attribute 'default nil :font "Monaco 14")
         ;; (set-frame-font "Monaco 14" nil t)
         )
        ((eq system-type 'gnu/linux)
         (set-face-attribute 'default nil :font "Ubuntu Mono 12"))
        )
  )

(defun cb-after-make-frame (frame)
  "Callback of after a FRAME made."
  (init-ui-look))

(defun init-web-settings ()
  "Init web settings."
  (interactive)
  ;; (electric-indent-local-mode -1)
  (setq tab-stop-list [2, 4, 6, 8, 10])
  (setq tab-width 2)
  )

;; -------------
;; so many hooks
;; -------------

;; 非常不好用的自动缩进 mode
;; (add-hook 'after-change-major-mode-hook
;;           (lambda()
;;             (when (not (derived-mode-p 'lisp-mode 'python-mode))
;;               (electric-indent-mode -1))))
(modify-syntax-entry ?_ "w")
(add-hook 'after-make-frame-functions 'cb-after-make-frame)

;; (setq show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(init-ui-look)
(global-auto-revert-mode)
(xterm-mouse-mode 1)
(electric-pair-mode -1)

;; emacs welcome page
(setq-default inhibit-startup-screen t)
(setq-default cursor-type 'box)
(setq-default truncate-lines t)
(setq-default eww-search-prefix "https://www.google.com/search?q=")
;; (setq-default python-shell-completion-native-enable nil)
(setq-default help-window-select t)
(setq vc-follow-symlinks t)
(setq-default org-agenda-files '("~/Dropbox/"))
(setq-default imenu-list-focus-after-activation t)
(setq-default imenu-list-size 35)
(setq-default org-log-done 'time)
(setq-default indent-tabs-mode nil)
(setq-default c-default-style "linux"
              c-basic-offset 4)
(setq confirm-kill-emacs 'y-or-n-p)
(setq-default python-shell-interpreter "python3")
(setq-default org-babel-python-command "python3")
(setq-default flycheck-python-pycompile-executable "python3")
(setq-default org-babel-sh-command "bash")
(setq make-backup-files nil)

(setq-default org-babel-python2-command "python")
(defun org-babel-execute:python2 (body params)
  "Execute BODY by python2 with PARAMS."
  (org-babel-eval "python2" body))

(defun org-babel-execute:python3 (body params)
  "Execute BODY by python2 with PARAMS."
  (org-babel-eval "python3" body))

(global-set-key (kbd "C-c e")
  (lambda ()
    (interactive)  ;; interactive can turn a function to a command
    (find-file user-init-file)))

(global-set-key (kbd "C-x t")
  (lambda ()
    (interactive)  ;; interactive can turn a function to a command
    (find-file "~/Dropbox/life_tracking.org")))

(org-babel-do-load-languages 'org-babel-load-languages
                             '((python . t)
                               (shell . t)  ;; emacs >= 26
                               (C . t)))
;; Enable mouse support
(unless window-system
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line))

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (progn
    (setq mac-option-modifier 'meta)
    ;; daemon mode
    (setq mac-command-modifier 'meta))
  (when (display-graphic-p)
    (setq mac-command-modifier 'meta))
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

(require 'package)
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

;; 加载已经安装的包，这样子，之后 requrie 一个包就可以让该包生效
(package-initialize)
(require-or-install-pkg 'use-package)
(setq use-package-verbose t)

;; 安装一些包
(use-package ivy
  :ensure t
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode 1)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)

  (global-set-key (kbd "C-c v s") 'ivy-switch-view)
  (global-set-key (kbd "C-c v c") 'ivy-push-view)
  (global-set-key (kbd "C-c v d") 'ivy-pop-view)
  )

;; isearch replacement
(use-package swiper
  :ensure t
  :config
  (global-set-key "\C-s" 'swiper))

(use-package counsel
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-c g") 'counsel-git-grep)
  (global-set-key (kbd "C-c C-p") 'counsel-projectile)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-fzf)
  (global-set-key (kbd "C-c f") 'grep-curword)
  (global-set-key (kbd "M-i") 'counsel-imenu)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
  )

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode)
  (global-set-key (kbd "C-c p f") 'counsel-projectile-find-file)
  )

(defun grep-curword ()
  "Grep word under cursor in whole project."
  (interactive)
  (counsel-git-grep nil (thing-at-point 'word))
  ;; (counsel-ag (thing-at-point 'word))
  )

(use-package fzf
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (global-set-key (kbd "C-c p p ") 'projectile-switch-project))

(use-package neotree
  :ensure t
  :config
  (global-set-key [f2] 'neotree-toggle))

(use-package magit
  :ensure t
  )
(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package pyvenv
  :ensure t)

(use-package org
  :ensure t)
(use-package company
  :ensure t)
(use-package ace-window
  :ensure t)
(use-package web-mode
  :ensure t
  :init
  (setq-default web-mode-enable-auto-indentation t)
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-css-indent-offset 2)
  (add-hook 'web-mode-hook 'init-web-settings)
  (add-hook 'js2-mode-hook 'init-web-settings)
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-missing-semi-one-line-override nil)
  (setq js2-strict-trailing-comma-warning nil)
  (setq js-indent-level 2)

  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\*fuo\\*\\'" . fuo-mode))
  )

(use-package js2-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
  )

(use-package thrift
  :ensure t)

(use-package exec-path-from-shell
  :ensure t)

(use-package goto-chg
  :ensure t)

(use-package diminish
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package anaconda-mode
  :ensure t)

(use-package company-anaconda
  :ensure t)

(use-package groovy-mode
  :ensure t)

(use-package page-break-lines
  :ensure t)

(use-package all-the-icons
  :ensure t)

(use-package imenu-list
  :ensure t
  :general
  (general-define-key :prefix "C-c i"
                      "l" 'imenu-list-smart-toggle
                      "r" 'imenu-list-refresh))

(use-package bm
  :ensure t
  :init
  (setq bm-cycle-all-buffers t)
  :general
  (general-define-key :prefix "C-c m"
                      "n" 'bm-next
                      "p" 'bm-previous
                      "m" 'bm-toggle)
  )
(use-package which-key
  :ensure t)
(use-package edit-server
  :ensure t)
(use-package general
  :ensure t)
(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode))

(use-package solarized-theme
  :ensure t)
(use-package yaml-mode
  :ensure t)
(use-package ein
  :ensure t)
(use-package htmlize
  :ensure t)
(use-package persp-mode
  :ensure t
  :init
  (setq persp-keymap-prefix (kbd "C-c w"))
  :config
  (global-set-key [f3] 'persp-prev)
  (global-set-key [f4] 'persp-next)
  (with-eval-after-load "persp-mode"
    (setq wg-morph-on nil) ;; switch off animation
    (setq persp-autokill-buffer-on-remove 'kill-weak)
    (add-hook 'after-init-hook #'(lambda () (persp-mode 1)))))

(use-package evil
  :ensure t
  :init
  (add-hook 'evil-mode-hook
            (lambda ()
              (setq general-default-keymaps 'evil-normal-state-map)
              (setq my-leader-default "<SPC>")
              (general-define-key :prefix my-leader-default
                                  "b" 'switch-to-buffer
                                  "e" '(lambda ()
                                         (interactive)
                                         (find-file user-init-file))
                                  "r" '(lambda ()
                                         (interactive)
                                         (load-file user-init-file))
                                  )
              (general-define-key
               "<SPC> p" '(:keymap projectile-command-map :package projectile))
              (general-define-key
               "<SPC> g" '(:keymap magit-mode-map :package magit))
              (general-define-key
               "<SPC> f" '(:keymap fuo-mode-map :package fuo))
              (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
              (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
              (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)

              (define-key evil-normal-state-map "tt" 'neotree-toggle)
              (define-key evil-normal-state-map "tb" 'imenu-list-smart-toggle)
              (define-key evil-normal-state-map "f" 'counsel-git-grep)

              ;; try to use emacs key in insert mode
              (define-key evil-insert-state-map (kbd "\C-k") 'kill-line)
              (define-key evil-insert-state-map (kbd "\C-d") 'delete-forward-char)
              (define-key evil-insert-state-map (kbd "\C-a") 'move-beginning-of-line)
              (define-key evil-insert-state-map (kbd "\C-e") 'move-end-of-line)
              (define-key evil-insert-state-map (kbd "\C-n") 'next-line)
              (define-key evil-insert-state-map (kbd "\C-p") 'previous-line)
              (define-key evil-insert-state-map (kbd "\C-v") 'scroll-up-command)
              (define-key evil-insert-state-map (kbd "\C-y") 'yank)

              (define-key evil-normal-state-map (kbd "\C-p") 'projectile-find-file)

              (setq-default evil-insert-state-cursor 'box)
              (modify-syntax-entry ?_ "w")))
  )

(use-package nyan-mode
  :ensure t)

;; (require-or-install-pkg 'fuo)
(when (file-exists-p "~/coding/emacs-fuo/fuo.el")
  (load "~/coding/emacs-fuo/fuo.el"))


;; ----------------------
;; every thing about evil
;; ----------------------

;; put evil at first place to make others works well with evil
;; (evil-mode 1)

;; ---------------
;; simple packages
;; ---------------

;; ------------
;; company-mode
;; ------------

(add-hook 'after-init-hook 'global-company-mode)


;; ----------
;; projectile
;; ----------
(projectile-mode)
(setq-default projectile-enable-caching t)

;; ----------
;; ace-window
;; ----------
(global-set-key (kbd "M-o") 'ace-window)


;; --------------------
;; exec-path-from-shell
;; --------------------
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

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

;; (global-undo-tree-mode)


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

;; ----------
;; Python IDE
;; ----------
(defun run-py ()
  "Run py file."
  (interactive)
  (shell-command
   (format "%s %s" python-shell-interpreter
           (buffer-file-name (current-buffer)))))
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook #'hs-minor-mode)
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-p") 'counsel-projectile)
            (local-set-key [f5] 'run-py)))

(eval-after-load "company"
                 '(add-to-list 'company-backends 'company-anaconda))

;; which-key

(which-key-mode)

;; perspEen


;; (perspeen-mode)
;; (setq-default perspeen-use-tab t)
;; (setq-default perspeen-keymap-prefix (kbd "C-\\"))

;; ---------
;; eyebrowse
;; ---------

;;(eyebrowse-mode t)
;;(eyebrowse-setup-opinionated-keys)
;;(setq-default eyebrowse-mode-line-style t)

;; --------
;; modeline
;; --------
;; (powerline-default-theme)
;; (sml-modeline-mode)



;; --------
;; diminish
;; --------

(diminish 'projectile-mode)
(diminish 'git-gutter-mode)
(diminish 'company-mode)
(add-hook 'company-mode-hook
          (lambda ()
            (diminish 'company-mode)
            ))
(diminish 'undo-tree-mode)
(diminish 'which-key-mode)
(diminish 'ivy-mode)

;; ---
;; fuo
;; ---

;; (add-hook 'evil-mode-hook
;;           (lambda ()
;;             (evil-define-key 'normal fuo-mode-map
;;               (kbd "<return>") 'fuo--play-current-line-song)))

;; (setq frame-title-format
;;       '("%b" "\t" (:eval (concat "["
;;          (string-join
;;           (--map
;;            (car it)
;;            (--map (cons (eyebrowse-format-slot it) (car it))
;;                   (eyebrowse--get 'window-configs)))
;;           ", ")
;;          "]"))
;;         )
;;       )


(setq custom-file "~/.emacs-custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;;(when (file-exists-p "~/coding/emacs-fuo/fuo.el")
;;  (load "~/coding/emacs-fuo/fuo.el"))

;;(custom-set-variables
;; '(custom-enabled-themes (quote (sanityinc-tomorrow-bright))))
(provide '.emacs)

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; .emacs ends here
