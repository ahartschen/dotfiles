(package-initialize)
(eval-when-compile
  (add-to-list 'load-path "/home/austin/.emacs.d/elpa/use-package-20181119.2350")
  (require 'use-package))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ledger-reports
   (quote
    (("bal general " "ledger bal")
     ("bal \"401k\"" "ledger bal \"401k\"")
     ("bal general cleared" "%(binary) -f %(ledger-file) bal \"Liabilities:Credit Cards\" \"Checking\" \"Savings\" \"Money Market\" \"CD\" --empty --cleared")
     ("bal general" "%(binary) -f %(ledger-file) bal \"Liabilities:Credit Cards\" \"Checking\" \"Savings\" \"Money Market\" \"CD\" --empty")
     ("bal" "%(binary) -f %(ledger-file) bal")
     ("reg" "%(binary) -f %(ledger-file) reg")
     ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
     ("account" "%(binary) -f %(ledger-file) reg %(account)"))))
 '(leetcode--loading-mode t nil (leetcode))
 '(line-number-mode nil)
 '(org-agenda-files nil)
 '(org-export-with-sub-superscripts (quote {}))
 '(package-selected-packages
   (quote
    (haskell-mode org-journal neotree django-mode python-django org-alert alert company-jedi py-autopep8 elpy leetcode kotlin-mode flutter dart-mode lsp-mode Company-quickhelp fireplace nyan-mode evil-anzu anzu which-key prettier-js md4rd dashboard web-mode doom-themes use-package company helm ledger-mode org-bullets org-plus-contrib evil-collection atom-one-dark-theme)))
 '(python-shell-interpreter "python3"))

;; Packages                                                                                       
(use-package evil
  :ensure evil
  :init

  ;; Tells us the number of matching string
  (use-package anzu
    :ensure t
    :diminish aznu-mode
    :config
    (global-anzu-mode 1))
  (use-package evil-anzu
    :ensure t)

  :config
  (evil-mode 1))

;; Style related
(use-package doom-themes
  :ensure doom-themes
  :config (load-theme 'doom-one t))
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; turn off bell 
(setq ring-bell-function 'ignore)

(setq org-todo-keywords 
      '((sequence "TODO" "STARTED" "DONE" "CANCELED" )))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("STARTED" . "yellow")
        ("CANCELED" . (:foreground "red" :weight bold))))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(setq org-agenda-files (list "~/Org/personal.org"))
  
(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x b" . helm-mini))
  :config (setq helm-split-window-in-side-p t))

(use-package company
  :ensure t
  :config
  (use-package company-quickhelp
    :ensure t
    :config
    (company-quickhelp-mode))
  (global-company-mode t))

(use-package company-jedi
  :commands company-jedi
  :init
  (defun use-package-company-add-company-jedi ()
    (unless (member 'company-jedi company-backends)
	  (add-to-list 'company-backends 'company-jedi)))
  (add-hook 'python-mode-hook #'use-package-company-add-company-jedi))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package ace-window
  :ensure t
  :bind ("M-o" . ace-window)
  :commands (ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
	aw-background t
	aw-dispatch-always t
	aw-dispatch-alist
	'((?0 aw-delete-window " Ace - Delete Window")
	  (?m aw-swap-window " Ace - Swap Window")
	  (?n aw-flip-window " Ace - Flip Window")
	  (?2 aw-split-window-vert " Ace - Split Vertical Window")
	  (?3 aw-split-window-horz " Ace - Split Horizontal Window")
	  (?1 delete-other-windows " Ace - Delete Other Windows"))))


;; Allow you to undo/redo changes to windor configuration
(when (fboundp 'winner-mode)
  (winner-mode 1))

(use-package magit
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(use-package tide
  :ensure t)

(use-package ledger-mode
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package nyan-mode
  :ensure t
  :config (nyan-mode 1))

(use-package fireplace
  :ensure t)

(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  (setq elpy-shell-echo-input nil))

(use-package py-autopep8
  :ensure t
  :config
  (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; These options are necessary for mysql to work on Windows
(when (eq system-type 'windows-nt)
  (setq sql-mysql-options '("-C" "-t" "-f" "-n"))
  (add-to-list 'default-frame-alist '(font . "Hack"))
  (set-face-attribute 'default nil
	              :family "Hack"))

(use-package js2-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode))

(use-package js2-refactor
  :ensure t
  :config
  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (js2r-add-keybindings-with-prefix "C-c C-r")
  (define-key js2-mode-map (kbd "C-k") #'js2r-kill))

(define-key js-mode-map (kbd "M-.") nil)

(add-hook 'js2-mode-hook (lambda ()
			   (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

;; Auto closing of brackets/braces/paranthesis/quotes/etc.
(electric-pair-mode 1)

(use-package alert
  :ensure t)

(require 'notifications)

(use-package org-alert
  :ensure t
  :config
  (setq alert-default-style 'notifications))

(use-package leetcode
  :ensure t
  :config
  (setq leetcode-prefer-language "python3"))

(defun my-python-mode-hook () 
  (linum-mode 1)) 

(add-hook 'python-mode-hook 'my-python-mode-hook) 
