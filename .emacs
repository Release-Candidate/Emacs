;;; Paths

(when (eq system-type 'windows-nt)
  (setenv "PATH" (concat (getenv "PATH") ";C:/tools/msys64/usr/bin;C:/Program Files (x86)/GnuWin32/bin;C:/tools;C:/Coq/bin"))
  (setq exec-path (append exec-path '("C:/tools/msys64/usr/bin")))
  (setq exec-path (append exec-path '("C:/Program Files (x86)/GnuWin32/bin")))
  (setq exec-path (append exec-path '("C:/Coq/bin"))))

;;; Key bindings

(setq w32-pass-apps-to-system nil)
(setq w32-apps-modifier 'hyper)

;; useless bindings
(global-set-key (kbd "C-n") nil)
(global-set-key (kbd "C-p") nil)


(global-set-key (kbd "H-+") 'delete-other-windows)
(global-set-key (kbd "H-é") 'delete-window)
(global-set-key (kbd "H-ľ") 'split-window-below)
(global-set-key (kbd "H-š") 'split-window-right)

(global-set-key (kbd "H-m") 'magit-status)
(global-set-key (kbd "H-g") 'goto-line-preview)
(global-set-key (kbd "H-j") 'avy-goto-word-or-subword-1)
(global-set-key (kbd "H-k") 'ace-window)
(global-set-key (kbd "H-u") 'undo-tree-visualize)
(global-set-key (kbd "H-t") 'dired-sidebar-toggle-sidebar)
(global-set-key (kbd "H-w") #'aya-create)
(global-set-key (kbd "H-y") #'aya-expand)

(global-set-key (kbd "H-<return>") (kbd "C-c C-c"))

(defun run-cmd-in-project-root ()
  (interactive)
  (projectile-mode t)
  (cd (projectile-acquire-root))
  (shell-command "start &"))

(global-set-key (kbd "<f1>") 'describe-mode)
(global-set-key (kbd "<f2>") 'describe-bindings)
(if (eq system-type 'windows-nt)
    (global-set-key (kbd "<f3>") 'run-cmd-in-project-root)
  (global-set-key (kbd "<f3>") 'vterm))

(global-set-key (kbd "M-š") 'join-line)
(global-set-key (kbd "M-č")
                (lambda ()
                  (interactive)
                  (join-line -1)))
(global-set-key (kbd "<H-right>") 'forward-sexp)
(global-set-key (kbd "<H-left>") 'backward-sexp)
(global-set-key (kbd "C-ä") 'paredit-forward-barf-sexp)
(global-set-key (kbd "C-ň") 'paredit-forward-slurp-sexp)
(global-set-key (kbd "C-ú") 'paredit-backward-barf-sexp)
(global-set-key (kbd "C-§") 'paredit-backward-slurp-sexp)

(if (eq system-type 'windows-nt)
    (global-set-key (kbd "C-M-&") 'drag-stuff-up)
  (global-set-key (kbd "C-M-\\") 'drag-stuff-up))
(global-set-key (kbd "C-M-y") 'drag-stuff-down)

(global-set-key (kbd "C-=") 'er/expand-region)

;;; Initialize Package System

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(setq package-selected-packages '(use-package))
(unless package-archive-contents
  package-refresh-contents())
(package-install-selected-packages)
(require 'use-package)

;; custom-set-variables saves it's values here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package)))

;;; Global Settings

(use-package emacs
  :init
  (add-hook 'before-save-hook 'my-prog-nuke-trailing-whitespace)
  (add-hook 'after-save-hook
            'executable-make-buffer-file-executable-if-script-p)
  :config
  ;; Save point position between sessions
  (save-place-mode 1)
  (setq save-place-forget-unreadable-files nil)
  ;; UTF-8 as default encoding
  (set-language-environment "UTF-8")
  (show-paren-mode t)
  (transient-mark-mode 1)
  (setq column-number-mode t)
  (when (display-graphic-p)
    (tool-bar-mode 0)
    (scroll-bar-mode 0))
  ;; remove menu
  ;; (menu-bar-mode 0)
  (setq inhibit-startup-screen t)
  ;; Use spaces, not tabs, for indentation.
  (setq-default indent-tabs-mode nil)
  (delete-selection-mode 1)
  (setq-default show-trailing-whitespace t)
  :custom
  (require-final-newline t)
  (display-time-24hr-format t)
  (display-time-default-load-average nil)
  (display-time-mode nil))

(defun my-prog-nuke-trailing-whitespace ()
  (when (derived-mode-p 'prog-mode)
    (delete-trailing-whitespace)))

;;;; Calendar

(setq calendar-week-start-day 1
      calendar-day-name-array ["Nedeľa" "Pondelok" "Utorok" "Streda" "Štvrtok" "Piatok" "Sobota"]
      calendar-day-abbrev-array ["Ne" "Po" "Ut" "St" "Št" "Pi" "So"]
      calendar-day-header-array ["Ne" "Po" "Ut" "St" "Št" "Pi" "So"]
      calendar-month-name-array ["Január" "Február" "Marec" "Apríl" "Máj" "Jún" "Júl" "August" "September" "Október" "November" "December"])

(setq
 holiday-solar-holidays nil
 holiday-bahai-holidays nil
 holiday-christian-holidays nil
 holiday-hebrew-holidays nil
 holiday-islamic-holidays nil
 holiday-oriental-holidays nil)


(setq holiday-general-holidays
      '((holiday-fixed 1 1 "Deň vzniku Slovenskej republiky")
        (holiday-fixed 1 6 "Zjavenie Pána (Traja králi)")
        (holiday-easter-etc -2 "Veľký piatok")
        (holiday-easter-etc 0 "Veľká noc")
        (holiday-easter-etc +1 "Veľkonočný pondelok")
        (holiday-fixed 5 1 "Sviatok práce")
        (holiday-fixed 5 8 "Deň víťazstva nad fašizmom")
        (holiday-fixed 7 5 "Sviatok svätého Cyrila a Metoda")
        (holiday-fixed 8 29 "Výročie SNP")
        (holiday-fixed 9 1 "Deň Ústavy Slovenskej republiky")
        (holiday-fixed 9 15 "Sedembolestná Panna Mária")
        (holiday-fixed 11 1 "Sviatok všetkých svätých")
        (holiday-fixed 11 17 "Deň boja za slobodu a demokraciu")
        (holiday-fixed 12 24 "Štedrý deň")
        (holiday-fixed 12 25 "Prvý sviatok vianočný")
        (holiday-fixed 12 26 "Druhý sviatok vianočný")))


;;; Package Configurations

;;;; LSP

(use-package lsp-mode
  :ensure t
  :hook
  (lsp-mode . lsp-lens-mode)
  :config
  (setq gc-cons-threshold 100000000)

  (setq read-process-output-max (* 1024 1024)) ;; 1mb

  (setq lsp-completion-provider :capf)

  (setq lsp-idle-delay 0.500)

  ;; if you want to change prefix for lsp-mode keybindings.
  (setq lsp-keymap-prefix "C-l"))


(use-package lsp-ui
  :ensure t
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

;;;; Flycheck

(use-package flycheck
  :ensure t
  :hook
  ((lsp-managed-mode . (lambda ()
                         (when (derived-mode-p 'sh-mode)
                           (setq my-flycheck-local-cache '((next-checkers . (sh-shellcheck)))))))
   (lsp-managed-mode . (lambda ()
                         (when (derived-mode-p 'markdown-mode)
                           (setq my-flycheck-local-cache '((next-checkers . (markdown-markdownlint-cli)))))))
   (lsp-managed-mode . (lambda ()
                         (when (derived-mode-p 'js-mode)
                           (setq my-flycheck-local-cache '((next-checkers . (javascript-eslint)))))))))

(advice-add 'flycheck-checker-get
            :around 'my-flycheck-local-checker-get)

;; Add buffer local Flycheck checkers after LSP for different major modes.
(defvar-local my-flycheck-local-cache nil)
(defun my-flycheck-local-checker-get (fn checker property)
  ;; Only check the buffer local cache for the LSP checker, otherwise we get
  ;; infinite loops.
  (if (eq checker 'lsp)
      (or (alist-get property my-flycheck-local-cache)
          (funcall fn checker property))
    (funcall fn checker property)))

;;;; Programming Languages

;;;;; Bash Mode / Shell Mode
(use-package sh-mode
  :hook
  (sh-mode . lsp))

;;;;; C Mode
(use-package c-mode
  :hook
  (c-mode . lsp))

;;;;; C++ Mode
(use-package c++-mode
  :hook
  (c++-mode . lsp))

;;;;; JS Mode
(use-package js-mode
  :hook
  (js-mode . lsp))

(eval-after-load 'js-mode
  '(progn
     (add-hook 'js-mode-hook #'add-node-modules-path)
     (add-hook 'js-mode-hook #'prettier-js-mode)))

;;;;; Typscript Mode
(use-package typescript-mode
  :ensure t
  :hook
  (typescript-mode . lsp))

(eval-after-load 'typescript-mode
  '(progn
     (add-hook 'typescript-mode-hook #'add-node-modules-path)))

;;;;; Load Node modules in project directory
(use-package add-node-modules-path
  :ensure t)

;;;;; CSS Mode
(use-package css-mode
  :ensure t
  :hook
  (css-mode . lsp))

;;;;; SCSS Mode
(use-package scss-mode
  :ensure t
  :hook
  (scss-mode . lsp))

;;;;; HTML Mode
(use-package mhtml-mode
  :ensure t
  :hook
  (mhtml-mode . lsp))

;;;;; XML Mode
(use-package nxml-mode
  :hook
  (nxml-mode . lsp))

;;;;; JSON Mode
(use-package json-mode
  :ensure t
  :hook
  (json-mode . lsp))

;;;;; Markdown Mode / GitHub Formatted Markdown Mode
(use-package markdown-mode
  :ensure t
  :commands
  (markdown-mode gfm-mode)
  :hook
  (markdown-mode . lsp)
  (gfm-mode . lsp)
  (markdown-mode . (lambda ()
                     (face-remap-add-relative 'default :family "Liberation Sans")))
  :mode
  (("README\\.md\\'" . gfm-mode)
   ("\\.md\\'" . gfm-mode)
   ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "pandoc")
  (progn
    (setq markdown-indent-on-enter 'indent-and-new-item))
  :custom-face
  (markdown-code-face ((t (:inherit fixed-pitch :family "Cascadia Code PL"))))
  (markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold))))
  (markdown-header-face-1 ((t (:inherit markdown-header-face :height 2.0))))
  (markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.8))))
  (markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.6))))
  (markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.4))))
  (markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.2)))))

;;;;;; Markdown TOC
(use-package markdown-toc
  :ensure t
  :hook
  (markdown-mode . markdown-toc-mode))

;;;;; YAML Mode
(use-package yaml-mode
  :ensure t
  :hook
  (yaml-mode . lsp))

;;;;; Ini Mode - no LSP!
(use-package ini-mode
  :ensure t)

;;;;; TOML Mode - no LSP!
(use-package toml-mode
  :ensure t)

;;;;; Clojure Mode
(use-package clojure-mode
  :ensure t
  :hook
  ((clojure-mode . lsp)
   (clojurescript-mode . lsp)
   (clojurec-mode . lsp)))

;;;;;; Clojure REPL
(use-package cider
  :ensure t)

;;;;; F# Mode
(use-package fsharp-mode
  :ensure t
  :hook
  (fsharp-mode . lsp))

;;;;; Python Mode
(use-package python-mode
  :ensure t
  :hook
  (python-mode . lsp))

;;;;;; Python LSP - Pyright
(use-package lsp-pyright
  :ensure t
  :hook
  (python-mode . (lambda ()
                   (require 'lsp-pyright)
                   (lsp))))  ; or lsp-deferred

;;;;;; Python Test Integration
(use-package python-pytest
  :ensure t)

;;;;;; Python Black formatter
(use-package python-black
  :ensure t
  :demand t
  :after python
  :hook
  (python-mode . python-black-on-save-mode))

;;;;; Coq Mode
(use-package company-coq
  :ensure t)
(use-package coq-mode
  :hook
  (coq-mode . company-coq-mode)
  :custom
  (coq-unicode-tokens-enable nil))

;;;;;; Proof General (Coq)
(use-package proof-general
  :ensure t)

;;;;; LISP

;;;;;; Sly (Slime) Mode
(use-package sly
  :ensure t
  :init
  (setq inferior-lisp-program "sbcl")
  (setq sly-lisp-implementations
        '((sbcl ("sbcl") :coding-system utf-8-unix))))

;;;;;; Lisp Mode
(use-package lisp-mode
  :hook
  (lisp-mode . sly))

;;;;;; Paredit
(use-package paredit
  :ensure t
  :bind
  (:map paredit-mode-map
        (("<C-left>" . nil)
         ("<C-right>" . nil)
         ("<C-M-left>" . nil)
         ("<C-M-right>" . nil)
         ("ESC <C-left>" . nil)
         ("ESC <C-right>" . nil)
         ("M-?" . nil)))
  :hook
  ((emacs-lisp-mode . enable-paredit-mode)
   (lisp-mode . enable-paredit-mode)
   (lisp-interaction-mode . enable-paredit-mode)
   (scheme-mode . enable-paredit-mode)
   (sly-mrepl-mode . enable-paredit-mode)
   (clojure-mode . enable-paredit-mode)
   (clojurescript-mode . enable-paredit-mode)
   (clojurec-mode . enable-paredit-mode)
   (cider-repl-mode . enable-paredit-mode)))

;;;;;; Company Mode
(use-package company
  :ensure t
  :hook
  ((emacs-lisp-mode . company-mode)
   (lisp-mode . company-mode)
   (sly-mrepl-mode . company-mode)
   (clojure-mode . company-mode)
   (clojurescript-mode . company-mode)
   (clojurec-mode . company-mode)
   (cider-repl-mode . company-mode)))

;;;;; Aggressive Indent
(use-package aggressive-indent
  :ensure t
  :hook
  ((emacs-lisp-mode . aggressive-indent-mode)
   (lisp-mode . aggressive-indent-mode)
   (lisp-interaction-mode . aggressive-indent-mode)
   (scheme-mode . aggressive-indent-mode)
   ;;(slime-repl-mode . aggressive-indent-mode)
   (css-mode . aggressive-indent-mode)
   (clojure-mode . aggressive-indent-mode)
   (clojurescript-mode . aggressive-indent-mode)
   (clojurec-mode . aggressive-indent-mode)))

;;;; General Packages

;;;;; Pretty Symbols
(use-package pretty-symbols
  :ensure t)

;;;;; Git
;;;;;; Magit Git mode
(use-package magit
  :ensure t)

;;;;;; Git Modes - gitignore and similar files
(use-package git-modes
  :ensure t)

;;;;; Org-Mode
(use-package org
  :ensure t
  :custom-face
  (org-level-1 ((t (:inherit outline-1 :extend nil :height 2.0))))
  (org-level-2 ((t (:inherit outline-2 :extend nil :height 1.8))))
  (org-level-3 ((t (:inherit outline-3 :extend nil :height 1.6))))
  (org-level-4 ((t (:inherit outline-4 :extend nil :height 1.4))))
  (org-level-5 ((t (:inherit outline-5 :extend nil :height 1.2)))))

;;;;; Outshine Mode - better Outline Mode
(use-package outshine
  :ensure t
  :hook
  (prog-mode . outshine-mode)
  :custom-face
  (outshine-level-1 ((t (:inherit outline-1 :height 2.0))))
  (outshine-level-2 ((t (:inherit outline-2 :height 1.8))))
  (outshine-level-3 ((t (:inherit outline-3 :height 1.6))))
  (outshine-level-4 ((t (:inherit outline-4 :height 1.4))))
  (outshine-level-5 ((t (:inherit outline-5 :height 1.2)))))

;;;;; System monitor Symon
(use-package symon
  :ensure t
  :custom
  (symon-monitors
   '(symon-current-time-monitor
     symon-windows-memory-monitor
     symon-windows-cpu-monitor))
  (symon-mode t))

;;;;; Fast Yasnippets
(use-package auto-yasnippet
  :ensure t)

;;;;; Yasnippets
(use-package yasnippet
  :ensure t
  :defer 1
  :config
  ;; My snippets
  (setq yas-snippet-dirs (append yas-snippet-dirs
                                 '("~/.emacs.d/snippets/")))
  (yas-global-mode 1))

;;;;;; Snippets
(use-package yasnippet-snippets
  :ensure t
  :after yasnippet
  :config
  (yasnippet-snippets-initialize))

;;;;;; Common Lisp Snippets
(use-package common-lisp-snippets
  :after yasnippet
  :ensure t)

;;;;;; Clojure Snippets
(use-package clojure-snippets
  :after yasnippet
  :ensure t)

;;;;;; Elm Snippets
(use-package elm-yasnippets
  :after yasnippet
  :ensure t)

;;;;; Delight - Hide Minor Modes in Modeline
(use-package delight
  :ensure t
  :config
  (delight '((abbrev-mode " Abv" abbrev)
             (eldoc-mode nil "eldoc")
             (per-buffer-theme-mode nil "per-buffer-theme")
             (rainbow-mode)
             (yas-minor-mode nil "yasnippet")
             (google-this-mode nil "google-this")
             (undo-tree-mode nil "undo-tree")
             (projectile-mode nil "projectile")
             (company-mode nil "company")
             (paredit-mode nil "paredit")
             (prettier-js-mode nil "prettier-js")
             (tree-sitter-mode nil "tree-sitter")
             (flycheck-mode nil "flycheck")
             (flyspell-mode nil "flyspell")
             (lsp-lens-mode nil "lsp-lens")
             (outline-minor-mode nil "outline")
             (outshine-mode nil "outshine")
             (aggressive-indent-mode nil "aggressive-indent")
             (overwrite-mode " Ov" t))))


;;;;; Google This
(use-package google-this
  :ensure t
  :config
  (google-this-mode 1))

;;;;; Mini Frame Mode
(use-package mini-frame
  :ensure t
  :config
  (mini-frame-mode +1)
  :custom
  (mini-frame-show-parameters '((top . 100) (width . 0.8) (left . 0.5))))

;;;;; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  :bind
  ;; Recommended keymap prefix on Windows/Linux
  (:map projectile-mode-map
        ("C-c p" . projectile-command-map)))

;;;;; Hydra
(use-package hydra
  :ensure t)

;;;;; Avy
(use-package avy
  :ensure t)

;;;;; Ace-Window
(use-package ace-window
  :ensure t)

;;;;; VTerm - Unix Terminal
(when (not (eq system-type 'windows-nt))
  (use-package vterm
    :ensure t))

;;;;; Powershell
(use-package powershell
  :ensure t)

;;;;; Completion Pckages

;;;;;; Selectrum
(use-package selectrum
  :ensure t
  :config
  (selectrum-mode +1))

;;;;;; Selectrum Prescient
(use-package selectrum-prescient
  :ensure t
  :config
  ;; to make sorting and filtering more intelligent
  (selectrum-prescient-mode +1)
  ;; to save your command history on disk, so the sorting gets more
  ;; intelligent over time
  (prescient-persist-mode +1))

;;;;;; Ido Vertical
(use-package ido-vertical-mode
  :ensure t)

;;;;;; Fuzzy Ido Search
(use-package flx-ido
  :ensure t)

;;;;; Goto Line with Preview
(use-package goto-line-preview
  :ensure t)

;;;;; Drag Stuff
(use-package drag-stuff
  :ensure t)

;;;;; Multiple Cursors
(use-package multiple-cursors
  :ensure t)

;;;;; Grepping with ag (Silver Searcher)

;;;;;; AG
(use-package ag
  :ensure t)

;;;;;; Wgrep for AG
(use-package wgrep-ag
  :ensure t)

;;;;; Treesitter Syntax Highlighting
(use-package tree-sitter
  :ensure t
  :config
  (global-tree-sitter-mode)
  :hook
  (tree-sitter-after-on . tree-sitter-hl-mode))

;;;;;; Treesitter Languages
(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)

;;;;; Enable richer annotations using the Marginalia package
(use-package marginalia
  :ensure t
  ;; Either bind `marginalia-cycle` globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init
  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

;;;;; Undo Tree
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

;;;;; Dired Sidebar
(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-show-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-no-delete-other-windows t)
  :hook
  (emacs-startup . dired-sidebar-show-sidebar))

;;;;;; Icons for Dired
(use-package all-the-icons-dired
  :ensure t)

;;;;; Emmet mode
(use-package emmet-mode
  :ensure t
  :hook
  ((sgml-mode . emmet-mode)
   (mhtml-mode . emmet-mode)
   (nxml-mode . emmet-mode)
   (css-mode  . emmet-mode)
   (scss-mode . emmet-mode)))

;;;;; Prettier Mode
(use-package prettier
  :ensure t)

;;;;;; Prettier JS
(use-package prettier-js
  :ensure t
  :hook
  ((css-mode . prettier-js-mode)
   (scss-mode . prettier-js-mode)
   (mhtml-mode . prettier-js-mode)
   (yaml-mode . prettier-js-mode)))

;;;;; Easy-Kill
(use-package easy-kill
  :ensure t
  :config
  (global-set-key [remap kill-ring-save] #'easy-kill)
  (global-set-key [remap mark-sexp] #'easy-mark))

;;;;; Expand Region
(use-package expand-region
  :ensure t)

;;;;; Flyspell
(use-package flyspell
  :ensure t
  :config
  (if (eq system-type 'windows-nt)
      (setq ispell-program-name "C:/ProgramData/hunspell/bin/hunspell.exe")
    (setq ispell-program-name "hunspell"))
  :hook
  ((text-mode . flyspell-mode)
   ;;(prog-mode . flyspell-prog-mode)
   (prog-mode . flyspell-mode)))

;;;;; Rainbow Delimeters
(use-package rainbow-delimiters
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode))

;;;;; Rainbow identifiers
(use-package rainbow-identifiers
  :ensure t
  :hook
  (prog-mode . rainbow-identifiers-mode))

;;; Font Setup

(when (eq system-type 'windows-nt)
  (set-face-attribute 'default nil
                      :font "Cascadia Code PL"
                      :weight 'normal))

(dolist (ft (fontset-list))
  (when (eq system-type 'windows-nt)
    (set-fontset-font ft 'unicode (font-spec :name "Cascadia Code PL")))
  (set-fontset-font ft 'unicode (font-spec :name "STIX Two Math") nil 'append))

(if (eq system-type 'windows-nt)
    (set-face-attribute 'default nil :height 120)
  (set-face-attribute 'default nil :height 110))
(set-face-attribute 'mode-line nil :height 100)

;;; Themes and Colors

;;;; Doom Modeline
(use-package doom-modeline
  :ensure t
  :custom
  (doom-modeline-buffer-encoding 'nondefault)
  (doom-modeline-hud nil)
  (doom-modeline-irc nil)
  (doom-modeline-minor-modes t)
  (doom-modeline-mode t)
  :custom-face
  (doom-modeline-bar ((t (:inherit highlight :height 0.8))))
  (doom-modeline-bar-inactive ((t (:background "grey20" :height 0.8))))
  (doom-modeline-buffer-file ((t (:inherit (mode-line-buffer-id bold) :height 0.8))))
  (doom-modeline-buffer-major-mode ((t (:inherit (mode-line-emphasis bold) :height 0.8))))
  (doom-modeline-buffer-minor-mode ((t (:inherit font-lock-doc-face :slant normal :height 0.8))))
  (doom-modeline-buffer-modified ((t (:inherit (error bold) :height 0.8))))
  (doom-modeline-buffer-path ((t (:inherit (mode-line-emphasis bold) :height 0.8))))
  (doom-modeline-buffer-timemachine ((t (:inherit doom-modeline-buffer-file :slant italic :height 0.8))))
  (doom-modeline-debug ((t (:inherit (font-lock-doc-face bold) :slant normal :height 0.8))))
  (doom-modeline-evil-emacs-state ((t (:inherit (font-lock-builtin-face bold) :height 0.8))))
  (doom-modeline-evil-insert-state ((t (:inherit (font-lock-keyword-face bold) :height 0.8))))
  (doom-modeline-evil-motion-state ((t (:inherit (font-lock-doc-face bold) :slant normal :height 0.8))))
  (doom-modeline-evil-normal-state ((t (:inherit doom-modeline-info :height 0.8))))
  (doom-modeline-evil-operator-state ((t (:inherit doom-modeline-buffer-file :height 0.8))))
  (doom-modeline-evil-replace-state ((t (:inherit doom-modeline-urgent :height 0.8))))
  (doom-modeline-evil-visual-state ((t (:inherit doom-modeline-warning :height 0.8))))
  (doom-modeline-highlight ((t (:inherit mode-line-emphasis :height 0.8))))
  (doom-modeline-host ((t (:inherit italic :height 0.8))))
  (doom-modeline-info ((t (:inherit (success bold) :height 0.8))))
  (doom-modeline-input-method ((t (:inherit (mode-line-emphasis bold) :height 0.8))))
  (doom-modeline-input-method-alt ((t (:inherit (font-lock-doc-face bold) :slant normal :height 0.8))))
  (doom-modeline-lsp-error ((t (:inherit error :weight normal :height 0.8))))
  (doom-modeline-lsp-running ((t (:inherit compilation-mode-line-run :slant normal :weight normal :height 0.8))))
  (doom-modeline-lsp-success ((t (:inherit success :weight normal :height 0.8))))
  (doom-modeline-lsp-warning ((t (:inherit warning :weight normal :height 0.8))))
  (doom-modeline-notification ((t (:inherit doom-modeline-warning :height 0.8))))
  (doom-modeline-panel ((t (:inherit mode-line-highlight :height 0.8))))
  (doom-modeline-persp-buffer-not-in-persp ((t (:inherit (font-lock-doc-face bold italic) :height 0.8))))
  (doom-modeline-persp-name ((t (:inherit (font-lock-comment-face italic) :height 0.8))))
  (doom-modeline-project-dir ((t (:inherit (font-lock-string-face bold) :height 0.8))))
  (doom-modeline-project-parent-dir ((t (:inherit (font-lock-comment-face bold) :height 0.8))))
  (doom-modeline-project-root-dir ((t (:inherit (mode-line-emphasis bold) :height 0.8))))
  (doom-modeline-repl-success ((t (:inherit success :weight normal :height 0.8))))
  (doom-modeline-repl-warning ((t (:inherit warning :weight normal :height 0.8))))
  (doom-modeline-spc-face ((t (:inherit mode-line :height 0.8))))
  (doom-modeline-unread-number ((t (:slant italic :weight normal :height 0.8))))
  (doom-modeline-urgent ((t (:inherit (error bold) :height 0.8))))
  (doom-modeline-vspc-face ((t (:inherit variable-pitch :height 0.8))))
  (doom-modeline-warning ((t (:inherit (warning bold) :height 0.8)))))

;;;; Doom Themes
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  (load-theme 'doom-zenburn t)
  :custom
  (nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
  (ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
  (vc-annotate-background "#2B2B2B")
  (vc-annotate-very-old-color "#DC8CC3")
  (vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))

;;;; Set Themes per Buffer
(use-package per-buffer-theme
  :ensure t
  :init
  (per-buffer-theme-mode)
  :config
  (setq per-buffer-theme/use-timer t)
  (setq per-buffer-theme/timer-idle-delay 0.1)
  (setq per-buffer-theme/default-theme 'doom-zenburn)
  (setq per-buffer-theme/themes-alist
        '(((:theme . notheme)
           (:buffernames nil)
           (:modes org-mode gfm-mode markdown-mode coq-mode proof-mode)))))


;;; Load Files in "~/.emacs.d/config"

(setq load-path (cons "~/.emacs.d/config" load-path))

;;;; Load File Templates
(load "templates")

;;; Automatically Inserted
;; custom-set-faces adds its values here
