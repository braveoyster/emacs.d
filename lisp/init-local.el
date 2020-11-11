;;; init-local.el --- Configure default locale -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; Settings for package archives
(setq package-archives '(("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")
                         ("gnu" . "http://mirrors.cloud.tencent.com/elpa/gnu/")
                         ("org" . "http://mirrors.cloud.tencent.com/elpa/org/")))

(require-package 'treemacs)
(require-package 'find-file-in-project)
(require-package 'youdao-dictionary)
(require-package 'editorconfig)
(require-package 'undo-tree)
(require-package 'expand-region)
(require-package 'lsp-mode)
(require-package 'lsp-ui)
(require-package 'dap-mode)
(require-package 'rg)


(global-set-key "\C-xj" 'treemacs)
(global-set-key "\M-op" 'find-file-in-project)
(global-set-key "\M-os" 'youdao-dictionary-search)
(global-set-key "\M-." 'lsp-ui-peek-find-definitions)
(global-set-key "\M-," 'lsp-ui-peek-find-references)
(global-set-key "\C-xg" 'magit)

(editorconfig-mode 1)
(global-undo-tree-mode)
(setq-default fill-column 80)
(setq global-display-fill-column-indicator-mode nil)

(set-frame-font "Fira Mono for Powerline 15")
(setq-default line-spacing 5)


(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)


(require 'lsp-mode)
(require 'lsp-ui)
(require 'dap-mode)
(dap-mode 1)

;; The modes below are optional

(dap-ui-mode 1)
;; enables mouse hover support
(dap-tooltip-mode 1)
;; use tooltips for mouse hover
;; if it is not enabled `dap-mode' will use the minibuffer.
(tooltip-mode 1)
;; displays floating panel with debug buttons
;; requies emacs 26+
(dap-ui-controls-mode 1)

(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'company-mode)

(add-hook 'js2-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'lsp)


(add-to-list 'exec-path "/Users/ryan/.nvm/versions/node/v12.16.1/bin")
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(delete-selection-mode 1)

;; Settings for company
(use-package company
  :diminish (company-mode " Com.")
  :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
  :hook (after-init . global-company-mode)
  :config (setq company-dabbrev-code-everywhere t
                company-dabbrev-code-modes t
                company-dabbrev-code-other-buffers 'all
                company-dabbrev-downcase nil
                company-dabbrev-ignore-case t
                company-dabbrev-other-buffers 'all
                company-require-match nil
                company-minimum-prefix-length 1
                company-show-numbers t
                company-tooltip-limit 20
                company-idle-delay 0
                company-echo-delay 0
                company-tooltip-offset-display 'scrollbar
                company-begin-commands '(self-insert-command)))

;; (use-package company-quickhelp
;;   :hook (prog-mode . company-quickhelp-mode)
;;   :init (setq company-quickhelp-delay 0.3))

;; Better sorting and filtering
(use-package company-prescient
  :init (company-prescient-mode 1))

;; ******************** PART4 searching ********************
;; Settings for ivy & counsel & swiper
(use-package ivy
  :defer 1
  :demand
  :diminish
  :hook (after-init . ivy-mode)
  :config (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-initial-inputs-alist nil
        ivy-count-format "%d/%d "
        enable-recursive-minibuffers t
        ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

(use-package counsel
             :after (ivy)
             :bind (("M-x" . counsel-M-x)
                    ("C-h b" . counsel-descbinds)
                    ("C-h f" . counsel-describe-function)
                    ("C-h v" . counsel-describe-variable)
                    ("C-x C-f" . counsel-find-file)
                    ("C-c f" . counsel-recentf)
                    ("C-c g" . counsel-git)))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper-isearch-backward))
  :config (setq swiper-action-recenter t
                swiper-include-line-number-in-search t))


(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)

(use-package vue-mode)


(use-package restclient
  :mode ("\\.http\\'" . restclient-mode))

(provide 'init-restclient)
;; ;; Settings for exec-path-from-shell
;; (use-package exec-path-from-shell
;;   :defer nil
;;   :if (memq window-system '(mac ns x))
;;   :init (exec-path-from-shell-initialize))
(require 'init-consts)
(require 'init-lsp)
(require 'init-web)
(require 'init-ui)

(provide 'init-local)
;;; init-local.el ends here
