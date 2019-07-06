;; interface size
(setq default-frame-alist
    `((top . 5)
      (left . 150)
      (width . 135)
      (height . 45)
      ))

;; set font 
(set-default-font "Courier New:pixelsize=20")
(set-fontset-font (frame-parameter nil 'font)
'han (font-spec :family "SimSun" :size 20))
(set-fontset-font (frame-parameter nil 'font)
'symbol (font-spec :family "SimSun" :size 20))
(set-fontset-font (frame-parameter nil 'font)
'cjk-misc (font-spec :family "SimSun" :size 20))
(set-fontset-font (frame-parameter nil 'font)
'bopomofo (font-spec :family "SimSun" :size 20))

;;default coding system
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; 开启常用的复制粘贴
(cua-mode t)

;; turn off tool-bar
(tool-bar-mode -1)

;; turn off scroll-bar
(scroll-bar-mode -1)

;显示匹配括号
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;以 y/n代表 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;启用时间显示设置
(display-time-mode 1)

;;时间使用24小时制
(setq display-time-24hr-format t)

;;时间显示包括日期和具体时间
(setq display-time-day-and-date t)

;; show linum-mode 显示行号
(global-linum-mode 1)

;; disable ring-bell
(setq ring-bell-function 'ignore)

;; open recent files 
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 17)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(setq inhibit-startup-message t)

;; buffer lists
;;(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)
;;(ido-mode 1)

;; a nice buffer-list
(defalias 'list-buffers 'ibuffer)

;; 关于window的undo
(winner-mode 1)

;; electric-pair-mode
(electric-pair-mode 1)

;; 不生成备份文件
(setq make-backup-files nil)

;;不生成#F#文件
(setq auto-save-default nil)

(use-package monokai-theme
  :ensure t)

(use-package try
    :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0))))) 
       ))

(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy))

(use-package counsel
  :ensure t)
(use-package swiper
  :ensure try
  :bind (("C-s" . swiper)
        ("C-r" . swiper)
	("C-c C-r" . ivy-resume)
	("M-x" . counsel-M-x)
	("C-x C-f" . counsel-find-file))
  :config
  (progn
     (ivy-mode 1)
     (setq ivy-use-virtual-buffers t)
     (setq ivy-display-style 'fancy)
     (global-set-key (kbd "<f1> f") 'counsel-describe-function)
     (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
     (global-set-key (kbd "<f1> l") 'counsel-load-library)
     (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
     (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
     (global-set-key (kbd "C-c g") 'counsel-git)
     (global-set-key (kbd "C-c j") 'counsel-git-grep)
     (global-set-key (kbd "C-c k") 'counsel-ag)
     (global-set-key (kbd "C-x l") 'counsel-locate)
     (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
     (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
     ))

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

(use-package ox-reveal
  :ensure ox-reveal)

(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(use-package htmlize
  :ensure t)

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

;; autocomplete and static analysis
(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))

;;python development
(use-package elpy
  :ensure t
  :config 
  (elpy-enable))

;;delete flymake
(with-eval-after-load 'elpy
(setq elpy-modules
    (delete 'elpy-module-flymake elpy-modules)))

(use-package web-mode
  :ensure t
  :config
       (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
       (setq web-mode-engines-alist
	     '(("django"    . "\\.html\\'")))
       (setq web-mode-ac-sources-alist
	     '(("css" . (ac-source-css-property))
	       ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

       (setq web-mode-enable-auto-closing t)

      (setq web-mode-enable-auto-quoting t)

      (setq web-mode-enable-current-element-highlight t)

      (setq web-mode-enable-current-column-highlight t)
      ;;(setq web-mode-enable-auto-pairing nil)
)

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs              (if (executable-find "python") 3 0)
          treemacs-deferred-git-apply-delay   0.5
          treemacs-display-in-side-window     t
          treemacs-file-event-delay           5000
          treemacs-file-follow-delay          0.2
          treemacs-follow-after-init          t
          treemacs-follow-recenter-distance   0.1
          treemacs-git-command-pipe           ""
          treemacs-goto-tag-strategy          'refetch-index
          treemacs-indentation                2
          treemacs-indentation-string         " "
          treemacs-is-never-other-window      nil
          treemacs-max-git-entries            5000
          treemacs-no-png-images              nil
          treemacs-no-delete-other-windows    t
          treemacs-project-follow-cleanup     nil
          treemacs-persist-file               (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-recenter-after-file-follow nil
          treemacs-recenter-after-tag-follow  nil
          treemacs-show-cursor                nil
          treemacs-show-hidden-files          t
          treemacs-silent-filewatch           nil
          treemacs-silent-refresh             nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-space-between-root-nodes   t
          treemacs-tag-follow-cleanup         t
          treemacs-tag-follow-delay           1.5
          treemacs-width                      35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
       (treemacs-git-mode 'deferred))
      (`(t . t)
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))
