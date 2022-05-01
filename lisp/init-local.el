;;; init-local.el --- customizes settings -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:
(require-package 'lsp-mode)
(require-package 'lsp-ui)
(require-package 'undo-tree)
(require-package 'editorconfig)
(require-package 'ivy)
(require-package 'use-package)
(require-package 'swiper)
(require-package 'expand-region)
(require-package 'nyan-mode)
(require-package 'vue-html-mode)
(require-package 'blamer)
(require-package 'lsp-java)
(require-package 'diminish)
(require-package 'minions)
(require-package 'doom-modeline)

;; (setq lsp-java-server-install-dir
;;       "~/.emacs/jdt-language-server-latest/")

(add-to-list 'load-path (expand-file-name "~/elisp"))
(require 'cache-path-from-shell)

;; (use-package lsp-java
;;   :defer t
;;   :init
;;   (setq lsp-java-server-install-dir
;;         "~/backups/src/jdt-language-server-latest/")
;;   :hook (java-mode . (lambda ()
;;                        (require 'lsp-java)
;;                        (lsp-common-set))))
;; (defun lsp-common-set ()
;;   (use-package lsp-ui
;;     :config
;;     (setq lsp-ui-doc-enable nil)
;;     (setq lsp-ui-sideline-enable nil)
;;     (define-key lsp-ui-mode-map [remap xref-find-references]
;;       #'lsp-ui-peek-find-references))
;;   (lsp)
;;   (setq-local company-backends
;;               '((company-yasnippet company-capf)
;;                 company-dabbrev-code company-dabbrev
;;                 company-files))
;;   (setq lsp-completion-styles '(basic))
;;   (define-key lsp-mode-map (kbd "S-<f2>") #'lsp-rename)
;;   (define-key lsp-mode-map (kbd "M-.") #'xref-find-definitions)
;;   (define-key lsp-mode-map (kbd "C-h .") #'lsp-describe-thing-at-point)
;;   (define-key lsp-mode-map (kbd "s-l") nil)
;;   (setq abbrev-mode nil))

;; (defun project-root (project)
;;   (car (project-roots project)))
(setq read-process-output-max (* 1024 1024))
(setq company-minimum-prefix-length 1
      company-idle-delay 0.0) ;; default is 0.2
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(set-frame-font "Andale Mono for Powerline 15")
(setq-default line-spacing 4)
;; set indent size
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)
;; (setq max-lisp-eval-depth 10000)
;; (setq max-specpdl-size 5)  ; default is 1000, reduce the backtrace giFlevel
;; (setq debug-on-error t)    ; now you should get a backtrace

(require 'lsp-mode)
(require 'lsp-ui)

(add-hook 'prog-mode-hook (lambda ()
                            (display-fill-column-indicator-mode 0)))

(add-hook 'prog-mode-hook 'subword-mode)
(add-hook 'js2-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'lsp)
;; (add-hook 'vue-mode-hook #'lsp)
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

;; project-find-file
(require 'project)
(global-set-key (kbd "M-o p") 'project-find-file)

(require 'undo-tree)
(global-undo-tree-mode)
(global-set-key (kbd "C-/") 'undo-tree-visualize)
(global-set-key (kbd "M-y") 'browse-kill-ring)

(global-set-key (kbd "C-,") 'goto-last-change)
(global-set-key (kbd "C-M-,") 'goto-last-change-reverse)
(global-set-key (kbd "<f5>") #'deadgrep)

(editorconfig-mode 1)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(global-set-key (kbd "C-x j") 'treemacs)

(require 'dap-node)
(add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))

(defun my/web-vue-setup()
  "Setup for js related."
  (message "web-mode use vue related setup")
  (setup-tide-mode)
  (prettier-js-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-select-checker 'javascript-eslint)
  (my/use-eslint-from-node-modules)
  (add-to-list (make-local-variable 'company-backends)
               '(comany-tide company-web-html company-css company-files))
  )

(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" "\\.vue\\'")
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-css-colorization t)
  (set-face-attribute 'web-mode-html-tag-face nil :foreground "royalblue")
  (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "powderblue")
  (set-face-attribute 'web-mode-doctype-face nil :foreground "lightskyblue")
  (setq web-mode-content-types-alist
        '(("vue" . "\\.vue\\'")))
  (use-package company-web
    :ensure t)
  (add-hook 'web-mode-hook (lambda()
                             (cond ((equal web-mode-content-type "html")
                                    (my/web-html-setup))
                                   ((member web-mode-content-type '("vue"))
                                    (my/web-vue-setup))
                                   )))
  )

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

;; (custom-set-variables
;;  '(markdown-command "/usr/local/bin/pandoc"))

(global-linum-mode 0)
;; (global-display-fill-column-indicator-mode 0)
;; (nyan-mode t)

(setq lsp-rust-analyzer-server-display-inlay-hints t)
(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))
(setq lsp-ui-sideline-show-code-actions t)
(setq lsp-headerline-breadcrumb-enable nil)
(setq lsp-diagnostics-provider t)
(setq lsp-modeline-diagnostics-enable t)

(set-background-color "#31343f")
;; (set-face-attribute 'default cur-frame :background "#31343f")
;; (add-to-list 'default-frame-alist '(background-color . "#31343f"))
;; (add-to-list 'default-frame-alist '(foreground-color . "#E0DFDB"))

(use-package dap-mode
  :ensure
  :config
  (dap-ui-mode)
  (dap-ui-controls-mode 1)

  (require 'dap-lldb)
  (require 'dap-gdb-lldb)
  ;; installs .extension/vscode
  (dap-gdb-lldb-setup)
  (dap-register-debug-template
   "Rust::LLDB Run Configuration"
   (list :type "lldb"
         :request "launch"
         :name "LLDB::Run"
         :gdbpath "rust-lldb"
         :target nil
         :cwd nil)))
;; (global-blamer-mode t)
(add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra)))

(use-package exec-path-from-shell
  :ensure
  :init (exec-path-from-shell-initialize))

(defhydra hydra-zoom (global-map "<f2>")
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out"))

(defhydra hydra-buffer-menu (:color pink
                                    :hint nil)
  "
^Mark^             ^Unmark^           ^Actions^          ^Search
^^^^^^^^-----------------------------------------------------------------
_m_: mark          _u_: unmark        _x_: execute       _R_: re-isearch
_s_: save          _U_: unmark up     _b_: bury          _I_: isearch
_d_: delete        ^ ^                _g_: refresh       _O_: multi-occur
_D_: delete up     ^ ^                _T_: files only: % -28`Buffer-menu-files-only
_~_: modified
"
  ("m" Buffer-menu-mark)
  ("u" Buffer-menu-unmark)
  ("U" Buffer-menu-backup-unmark)
  ("d" Buffer-menu-delete)
  ("D" Buffer-menu-delete-backwards)
  ("s" Buffer-menu-save)
  ("~" Buffer-menu-not-modified)
  ("x" Buffer-menu-execute)
  ("b" Buffer-menu-bury)
  ("g" revert-buffer)
  ("T" Buffer-menu-toggle-files-only)
  ("O" Buffer-menu-multi-occur :color blue)
  ("I" Buffer-menu-isearch-buffers :color blue)
  ("R" Buffer-menu-isearch-buffers-regexp :color blue)
  ("c" nil "cancel")
  ("v" Buffer-menu-select "select" :color blue)
  ("o" Buffer-menu-other-window "other-window" :color blue)
  ("q" quit-window "quit" :color blue))

(define-key Buffer-menu-mode-map "." 'hydra-buffer-menu/body)

(defun ora-ex-point-mark ()
  (interactive)
  (if rectangle-mark-mode
      (exchange-point-and-mark)
    (let ((mk (mark)))
      (rectangle-mark-mode 1)
      (goto-char mk))))

(require 'hydra-examples)


(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)
(require 'dap-java)
(setq lsp-java-vmargs
      '(
        "-noverify"
        "-Xmx2G"
        "-XX:+UseG1GC"
        "-XX:+UseStringDeduplication"
        ;; When you need to use lombok, uncomment the below and change it to your path
        "-javaagent:/Users/yanfang/.m2/repository/org/projectlombok/lombok/1.18.20/lombok-1.18.20.jar"
        )

      ;; Don't organise imports on save
      ;; lsp-java-save-actions-organize-imports nil
      )

;; (define-key lsp-mode-map (kbd "C-l") lsp-command-map))
;; (use-package
;;   :bind
;;   ("C-c C-l" . lsp-command-map)
;; (with-eval-after-load 'lsp-mode
;;   (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)))
;;; inits
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package diminish)
(use-package minions
  :hook (doom-modeline-mode . minions-mode))
(require 'diminish)

(diminish 'rainbow-mode)                                       ; Hide lighter from mode-line
(diminish 'rainbow-mode " Rbow")                               ; Replace rainbow-mode lighter with " Rbow"
(diminish 'rainbow-mode 'rainbow-mode-lighter)                 ; Use raingow-mode-lighter variable value
(diminish 'rainbow-mode '(" " "R-" "bow"))                     ; Replace rainbow-mode lighter with " R-bow"
(diminish 'rainbow-mode '((" " "R") "/" "bow"))                ; Replace rainbow-mode lighter with " R/bow"
(diminish 'rainbow-mode '(:eval (format " Rbow/%s" (+ 2 3))))  ; Replace rainbow-mode lighter with " Rbow/5"
(diminish 'rainbow-mode                                        ; Replace rainbow-mode lighter with greened " Rbow"
          '(:propertize " Rbow" face '(:foreground "green")))
(diminish 'rainbow-mode                                        ; If rainbow-mode-mode-linep is non-nil " Rbow/t"
          '(rainbow-mode-mode-linep " Rbow/t" " Rbow/nil"))
(diminish 'rainbow-mode '(3 " Rbow" "/" "s"))                  ; Replace rainbow-mode lighter with " Rb"

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(use-package doom-modeline
  :after eshell ;; Make sure it gets hooked after eshell
  :hook (after-init . doom-modeline-init)
  :custom-face
  (mode-line ((t (:height 0.85))))
  (mode-line-inactive ((t (:height 0.85))))
  :custom
  (doom-modeline-height 15)
  (doom-modeline-bar-width 6)
  (doom-modeline-lsp t)
  (doom-modeline-github nil)
  (doom-modeline-mu4e nil)
  (doom-modeline-irc nil)
  (doom-modeline-minor-modes t)
  (doom-modeline-persp-name nil)
  (doom-modeline-buffer-file-name-style 'truncate-except-project)
  (doom-modeline-major-mode-icon nil))

(set-face-attribute 'default nil :font "Fira Code Retina" :height 160)

(use-package spacegray-theme :defer t)
(use-package doom-themes :defer t)
(load-theme 'doom-palenight t)
(doom-themes-visual-bell-config)

;; Set up the visible bell
(setq visible-bell t)
(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)       ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq use-dialog-box nil) ;; Disable dialog boxes since they weren't working in Mac OSX

(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))




(provide 'init-local)
;;; init-local.el ends here
