;;; init-evil-plugs.el --- packages that are ports from vim plugins

(require 'init-evil)

(straight-use-package        ; https://github.com/zmaas/evil-unimpaired
 '(evil-unimpaired :type git :host github :repo "zmaas/evil-unimpaired"))
(straight-use-package 'evil-snipe)      ; https://github.com/hlissner/evil-snipe

;;; evil-unimpared
(evil-unimpaired-mode)

;;; evil-snipe
;; align with vim-sneak
(setq evil-snipe-smart-case t
      evil-snipe-scope 'visible
      evil-snipe-use-vim-sneak-bindings t)
(evil-snipe-mode)

(provide 'init-evil-plugs)
