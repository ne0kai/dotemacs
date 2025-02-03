;;; init-prog.el --- IDE experience for programming
(straight-use-package 'treemacs-nerd-icons)     ; https://github.com/rainstormstudio/treemacs-nerd-icons
;; reference jump, documents, git client, file explorer.

(require 'init-evil)
(require 'init-navigation)

(straight-use-package 'consult-project-extra) ; use consult to select xref locations with preview
(straight-use-package 'dumb-jump)       ; https://github.com/jacktasia/dumb-jump
(straight-use-package 'devdocs)         ; https://github.com/astoff/devdocs.el
(straight-use-package 'magit)           ; https://github.com/magit/magit
(straight-use-package 'evil-magit)      ; https://github.com/emacs-evil/evil-magit
(straight-use-package 'treemacs)        ; https://github.com/Alexander-Miller/treemacs
(straight-use-package 'treemacs-nerd-icons)     ; https://github.com/rainstormstudio/treemacs-nerd-icons
(straight-use-package 'imenu-list)  ; https://github.com/bmag/imenu-list 

;;; project.el
(global-set-key (kbd "C-x p f") 'consult-project-extra-find)

;;; Xref and dumb-jump M-. / gd to go to definition
;; use faster search tool
(setq xref-search-program 'ripgrep
      dumb-jump-prefer-searcher 'rg)
;; use consult to select xref locations with preview
(setq xref-show-definitions-function #'consult-xref
      xref-show-xrefs-function #'consult-xref)
;; use dumb-jump with xref
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;;; Devdocs
(global-set-key (kbd "C-h d") 'devdocs-lookup) ; 'apropos-documentation
(setq shr-use-fonts nil)                       ; devdocs use shr to render texts
(add-hook 'c-mode-hook
          (lambda () (setq-local devdocs-current-docs '("c"))))
(add-hook 'c++-mode-hook
          (lambda () (setq-local devdocs-current-docs '("cpp"))))
(add-hook 'java-mode-hook
          (lambda () (setq-local devdocs-current-docs '("openjdk~21"))))
(add-hook 'kotlin-mode-hook
          (lambda () (setq-local devdocs-current-docs '("kotlin~1.9"))))

;;; Magit
(with-eval-after-load 'magit
  (require 'evil-magit)
  (setq evil-magit-use-y-for-yank nil))

;;; Treemacs
;; Components included in treemacs
(straight-use-package 'treemacs-evil)   ; included in treemacs
(straight-use-package 'treemacs-magit)  ; included in treemacs

(global-set-key (kbd "C-x t") 'treemacs) ; forward-char
 
(with-eval-after-load 'treemacs
  (require 'treemacs-evil)
  (require 'treemacs-magit)
  (require 'treemacs-nerd-icons)

  (define-key evil-treemacs-state-map (kbd "f") #'treemacs-select-directory)

  (treemacs-load-theme "nerd-icons")
  (treemacs-filewatch-mode)
  (treemacs-git-mode 'simple)

  (setq treemacs-width 30
        treemacs-wide-toggle-width 50))

;;; imenu-list
;; use the same prefix key as treemacs
(global-set-key (kbd "C-x m") 'imenu-list-smart-toggle) ; compose-mail
(setq imenu-list-size 0.25)

(provide 'init-prog)
