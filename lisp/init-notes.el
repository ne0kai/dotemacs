;;; init-notes.el --- Writing (Markdown) notes in Emacs

(straight-use-package 'writeroom-mode)  ; https://github.com/joostkremers/writeroom-mode
(straight-use-package 'consult-notes)   ; https://github.com/mclear-tools/consult-notes

;;; Writeroom-mode
;; disable native fullscreen (stay in the workspace)
(setq writeroom-fullscreen-effect 'maximized)

;; default width is 80 characters.
(with-eval-after-load 'writeroom-mode
  (define-key writeroom-mode-map (kbd "C-<") #'writeroom-decrease-width)
  (define-key writeroom-mode-map (kbd "C->") #'writeroom-increase-width)
  (define-key writeroom-mode-map (kbd "C-=") #'writeroom-adjust-width))

(defun my-writing-mode ()
    (interactive)
    (writeroom-mode)
    (setq line-spacing 5)
    (cond
     (sys/macp (setq buffer-face-mode-face '(:family "iA Writer Duo S" :height 170)))
     (sys/linuxp (setq buffer-face-mode-face '(:family "iA Writer Duospace" :height 130))))
    (buffer-face-mode))

;;; consult-notes
(setq consult-notes-file-dir-sources
      '(("org" ?o "~/org/")
        ("mind" ?m "~/mind")))

(global-set-key (kbd "C-c n") 'consult-notes-search-in-all-notes)

(provide 'init-notes)
