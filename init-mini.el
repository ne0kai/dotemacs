;;; init-mini.el
;; emacs -q -l ~/.emacs.d/init-mini.el

;;; configs in early-init.el
(setq package-enable-at-startup nil)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(setq-default mode-line-format nil)

;;; system information
(defconst sys/winp
  (eq system-type 'windows-nt)
  "Are we running on a Windows system?")
(defconst sys/linuxp
  (eq system-type 'gnu/linux)
  "Are we running on a GNU/Linux system?")
(defconst sys/macp
  (eq system-type 'darwin)
  "Are we running on a Mac system?")

;;; update load path
(push (expand-file-name "lisp" user-emacs-directory) load-path)

;;; base
(require 'init-package)
(require 'init-defaults)
(require 'init-evil)
(require 'init-evil-bindings)

;;; Interface
(cond
 (sys/winp
  (set-face-attribute 'default nil :height 140))
 (sys/macp
  (set-face-attribute 'default nil :family "SFMono Nerd Font" :height 170)
  (set-face-attribute 'variable-pitch nil :family "Palatino" :height 170)
  (set-fontset-font t 'symbol "Apple Color Emoji" nil 'prepend))
 (sys/linuxp
  (set-face-attribute 'default nil :family "SFMono Nerd Font Mono" :height 130)
  (set-face-attribute 'variable-pitch nil :family "EB Garamond" :height 155)
  (set-face-attribute 'fixed-pitch-serif nil :family "SFMono Nerd Font Mono" :height '130)
  ;; Emacs recognize Apple Emoji (font already installed)
  (set-fontset-font t 'symbol "Apple Color Emoji" nil 'prepend)))

;;; editing
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;;; set org-agenda-files
(setq org-agenda-files '("~/org"))

;;; custom file
(setq custom-file (no-littering-expand-etc-file-name "custom.el"))
(load custom-file 'noerror)
