;;; init-notes.el --- Writing (Markdown) notes in Emacs

(straight-use-package 'writeroom-mode)  ; https://github.com/joostkremers/writeroom-mode
(straight-use-package 'obsidian)        ; https://github.com/licht1stein/obsidian.el
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

;;; Obsidian
(obsidian-specify-path "~/mind")

;; Define obsidian-mode bindings
(add-hook
 'obsidian-mode-hook
 (lambda ()
   ;; Replace standard command with Obsidian.el's in obsidian vault:
   (local-set-key (kbd "C-c C-o") 'obsidian-follow-link-at-point)

   ;; Use either `obsidian-insert-wikilink' or `obsidian-insert-link':
   (local-set-key (kbd "C-c C-l") 'obsidian-insert-wikilink)

   ;; Following backlinks
   (local-set-key (kbd "C-c C-b") 'obsidian-backlink-jump)))

(global-set-key (kbd "C-c o") 'obsidian-jump)
(global-obsidian-mode)

;;; journal entry
(defun my-journal-entry ()
  "Open today's journal file and insert a new entry with the current time."
  (interactive)
  (let* ((date (format-time-string "%Y-%m-%d"))           ; Get today's date
         (filename (concat "~/mind/daily/" date ".md"))  ; Build the filename
         (time (format-time-string "\n## %H:%M ")))         ; Format the time as '## hh:mm'
    
    ;; Open the file and insert the journal entry at the end
    (find-file filename)
    (my-writing-mode)
    (goto-char (point-max))   ; Go to the end of the file
    (insert time)             ; Insert the formatted time entry
    (evil-insert-state)))

(global-set-key (kbd "C-c j") #'my-journal-entry)

;;; consult-notes
(setq consult-notes-file-dir-sources
      '(("org" ?o "~/org/")
        ("mind" ?m "~/mind")))

(global-set-key (kbd "C-c n") 'consult-notes-search-in-all-notes)

(provide 'init-notes)
