;;; init-local.el --- Configure default locale -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(require-package 'treemacs)
(require-package 'find-file-in-project)
(require-package 'youdao-dictionary)
(require-package 'editorconfig)
(require-package 'undo-tree)
(require-package 'expand-region)
(require-package 'lsp-mode)
(require-package 'lsp-ui)
(require-package 'dap-mode)

(global-set-key "\C-xj" 'treemacs)
(global-set-key "\M-op" 'find-file-in-project)
(global-set-key "\M-os" 'youdao-dictionary-search)
(global-set-key "\M-." 'lsp-ui-peek-find-definitions)
(global-set-key "\M-," 'lsp-ui-peek-find-references)
(global-set-key "\C-xg" 'magit)

(editorconfig-mode 1)
(global-undo-tree-mode)
(setq-default fill-column 80)
(global-display-fill-column-indicator-mode -1)

(set-frame-font "Andale Mono for Powerline 14")
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

(add-hook 'js2-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'lsp)


(add-to-list 'exec-path "/Users/ryan/.nvm/versions/node/v12.16.1/bin")
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(delete-selection-mode 1)
(provide 'init-local)
;;; init-local.el ends here
