;;; init.el

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

;;; evil
(require 'init-evil)
(require 'init-evil-bindings)
(require 'init-evil-plugs)

;;; core
(require 'init-navigation)
(require 'init-completion)
(require 'init-edit)
(require 'init-input)
(require 'init-interface)

;;; org
(require 'init-org)
;; (require 'init-org-babel)
(require 'init-org-gtd)

;;; lang
(require 'init-c)
(require 'init-lisp)
;; (require 'init-python)
(require 'init-latex)
(require 'init-java)
(require 'init-markdown)

;;; extra
(require 'init-prog)
(require 'init-dired)
(require 'init-notes)
;; (require 'init-utility)

;;; custom file
(setq custom-file (no-littering-expand-etc-file-name "custom.el"))
(load custom-file 'noerror 'nomessage)
