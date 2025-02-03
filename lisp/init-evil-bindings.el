;;; init-evil-bindings.el --- My own evil-collection
;; https://github.com/emacs-evil/evil-collection
;; The comment after line is the function that key originally represents

;;; Evil initial states
(dolist (states '((minibuffer-inactive-mode . emacs)
             (calendar-mode . emacs)
             (dired-mode . emacs)
             (Info-mode . emacs)
             (woman-mode . emacs)
             (term-mode . emacs)
             (special-mode . emacs)
             (grep-mode . emacs)
             (erc-mode . emacs)
             (xref--xref-buffer-mode . emacs)
             (compilation-mode . emacs)
             (dashboard-mode . emacs)
             (elfeed-search-mode . emacs)

             (eshell-mode . insert)
             (shell-mode . insert)

             (elfeed-show-mode . motion)

	     (treemacs-mode . normal)))      ; for treemacs-evil
  (evil-set-initial-state (car states) (cdr states)))

;; Insure insert state
(add-hook 'org-capture-mode-hook #'evil-insert-state) ; Org capture

;;; Macros for evil
(defmacro my-evil-search-macro (local-map)
  "adds evil search keybindings to local-map"
  `(progn
     (define-key ,local-map (kbd "/") 'evil-search-forward)
     (define-key ,local-map (kbd "?") 'evil-search-backward)
     (define-key ,local-map (kbd "n") 'evil-search-next)
     (define-key ,local-map (kbd "N") 'evil-search-previous)))

(defmacro my-evil-jk-line-macro (local-map)
  "maps j/k to next-line/previous-line in local-map"
  `(progn
     (define-key ,local-map (kbd "j") 'next-line)
     (define-key ,local-map (kbd "k") 'previous-line)))

;;; Minibuffer keybinding
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (local-set-key (kbd "C-h") 'backward-delete-char)
            (local-set-key (kbd "C-w") 'backward-kill-word)
            (local-set-key (kbd "C-u") 'kill-whole-line)
	    (local-set-key (kbd "M-h") (lookup-key global-map (kbd "C-h")))))

;;; Org-agenda
(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map "j" 'org-agenda-next-line) ; org-agenda-goto-date
  (define-key org-agenda-mode-map "k" 'org-agenda-previous-line) ; org-agenda-capture
  (define-key org-agenda-mode-map "K" 'org-agenda-capture) ; self-inserted
  (define-key org-agenda-mode-map "D" 'org-agenda-goto-date) ; org-agenda-toggle-diary

  ;; Manipulate date using H/L as in evil-org-mode
  (define-key org-agenda-mode-map "H" 'org-agenda-do-date-earlier) ; org-agenda-holidays, bound to h too
  (define-key org-agenda-mode-map "L" 'org-agenda-do-date-later)) ; org-agenda-recenter
  
;;; Dired-mode
(with-eval-after-load 'dired
  (my-evil-search-macro dired-mode-map)
  (define-key dired-mode-map "j" 'dired-next-line)
  (define-key dired-mode-map "k" 'dired-previous-line)
  (define-key dired-mode-map "J" 'dired-goto-file)      ; undefined
  (define-key dired-mode-map "K" 'dired-do-kill-lines)) ; undefined

;;; iBuffer
(with-eval-after-load 'ibuffer
  (define-key ibuffer-mode-map "j" 'ibuffer-forward-line)
  (define-key ibuffer-mode-map "k" 'ibuffer-backward-line)
  (define-key ibuffer-mode-map "J" 'ibuffer-goto-file) ; undefined
  (define-key ibuffer-mode-map "K" 'ibuffer-do-kill-lines)) ; undefined

;;; Info-mode
(with-eval-after-load 'info
  (my-evil-jk-line-macro Info-mode-map))

;;; Imenu-list
(with-eval-after-load 'imenu-list
  (my-evil-jk-line-macro imenu-list-major-mode-map))

;;; bookmark-bmenu
(with-eval-after-load 'bookmark
  (my-evil-jk-line-macro bookmark-bmenu-mode-map))

;;; elfeed
(with-eval-after-load 'elfeed
  (my-evil-jk-line-macro elfeed-search-mode-map)
  (define-key elfeed-show-mode-map (kbd "u") 'elfeed-show-visit)) ; evil-undo

;;; PDF-mode
(with-eval-after-load 'pdf-view
  (define-key pdf-view-mode-map "j" 'pdf-view-next-line-or-next-page)
  (define-key pdf-view-mode-map "k" 'pdf-view-previous-line-or-previous-page))

;;; grep and rg
(with-eval-after-load 'grep
  (define-key grep-mode-map (kbd "j") 'next-error-no-select)
  (define-key grep-mode-map (kbd "k") 'previous-error-no-select))

(with-eval-after-load 'rg
  (define-key rg-mode-map (kbd "j") 'next-error-no-select)
  (define-key rg-mode-map (kbd "k") 'previous-error-no-select))

;;; epub-mode
(with-eval-after-load 'nov
  (my-evil-jk-line-macro nov-mode-map))

(provide 'init-evil-bindings)
