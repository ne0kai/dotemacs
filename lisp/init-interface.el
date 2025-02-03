;;; init-interface.el --- Minimal and elegant interface for Emacs

;; Font, Theme, Dashboard, Modeline
; https://github.com/purcell/color-theme-sanityinc-tomorrow
(straight-use-package 'color-theme-sanityinc-tomorrow)
(straight-use-package 'color-theme-sanityinc-solarized)
(straight-use-package 'dashboard)       ; https://github.com/emacs-dashboard/emacs-dashboard
(straight-use-package 'anzu)            ; https://github.com/emacsorphanage/anzu
(straight-use-package 'evil-anzu)       ; https://github.com/emacsorphanage/evil-anzu
(straight-use-package 'telephone-line)  ; https://github.com/dbordak/telephone-line
(straight-use-package                   ; https://github.com/manateelazycat/awesome-tray
 '(awesome-tray :type git :host github :repo "manateelazycat/awesome-tray"))

;;; Font
(cond
 (sys/winp
  (set-face-attribute 'default nil :family "Consolas" :height 140))
 (sys/macp
  (set-face-attribute 'default nil :family "RobotoMono Nerd Font" :height 170)
  (set-face-attribute 'variable-pitch nil :family "Palatino" :height 190)
  (set-fontset-font t 'symbol "Apple Color Emoji" nil 'prepend))
 (sys/linuxp
  (set-face-attribute 'default nil :family "SFMono Nerd Font Mono" :height 130)
  (set-face-attribute 'variable-pitch nil :family "Libertinus Sans" :height 140)
  (set-face-attribute 'fixed-pitch-serif nil :family "SFMono Nerd Font Mono" :height '130)
  ;; Emacs recognize Apple Emoji (font already installed)
  (set-fontset-font t 'symbol "Apple Color Emoji" nil 'prepend)))

;; shortcut for change font size
(defun my-change-font-size (new-size)
  "Change the font size to the given value"
  (interactive "nNew font size (default 17): ")
  (set-face-attribute 'default nil :family "RobotoMono Nerd Font" :height (* 10 new-size)))
(global-set-key (kbd "C-x -") #'my-change-font-size)

;;; Theme
(load-theme 'sanityinc-tomorrow-day t)

;;; Dashboard
(dashboard-setup-startup-hook)
(setq dashboard-startup-banner 2
      dashboard-items '((agenda . 5)(recents . 5)(projects . 5)))
(setq dashboard-agenda-tags-format nil
      dashboard-agenda-sort-strategy '(time-up)
      dashboard-agenda-time-string-format "%m-%d")
(setq dashboard-footer-messages '("If today were the last day of my life, would I want to do what I am about to do today?" "Your time is limited, so don't waste it living someone else's life."))
(define-key dashboard-mode-map (kbd "SPC") 'dashboard-return)

;;; anzu
(setq anzu-cons-mode-line-p nil)
(add-hook 'emacs-startup-hook 'global-anzu-mode)
(with-eval-after-load 'evil
  (require 'evil-anzu))

;;; awesome-tray
(setq awesome-tray-active-modules
      '("anzu" "clock")
      awesome-tray-date-format "%-H:%-M"
      awesome-tray-hide-mode-line nil)
(add-hook 'emacs-startup-hook 'awesome-tray-mode)

;;; telephone-line
(setq telephone-line-lhs
      '((evil   . (telephone-line-evil-tag-segment))
        (accent . (telephone-line-vc-segment
                   telephone-line-erc-modified-channels-segment
                   telephone-line-process-segment))
        (nil    . (telephone-line-buffer-segment))))

(setq telephone-line-rhs
      '((nil    . (telephone-line-misc-info-segment))
        (accent . (telephone-line-major-mode-segment))
        (evil   . (telephone-line-airline-position-segment))))

(telephone-line-mode)

(provide 'init-interface)
