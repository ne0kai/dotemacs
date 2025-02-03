;;; init-org-base.el --- Org mode modern appearance and editing

(require 'init-evil)

(straight-use-package 'org-modern)      ; https://github.com/minad/org-modern 
(straight-use-package 'evil-org)        ; https://github.com/Somelauw/evil-org-mode

;;; Evil Org
;; Basic keys are always enabled
(with-eval-after-load 'org
  (require 'evil-org)
  (add-hook 'org-mode-hook 'evil-org-mode)
  (evil-org-set-key-theme '(textobjects insert navigation additional shift todo))
  (setq evil-org-use-additional-insert t)	; Use additional bindings in insert mode
)

;;; General
;; Global bindings
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-'") nil) ; org-cycle-agenda-files. flyspell
)

;; Applications for opening 'file:path' items in a document
(setq org-file-apps '((auto-mode .emacs)
		      (directory . emacs)
		      ("\\.pdf\\'" . emacs)))

;;; Appearance
;; Enable org-modern-mode
(global-org-modern-mode)

;; Beautify Headings
(setq org-modern-hide-stars nil       ; Conflict with the indent mode
      org-startup-indented t	      ; Indent mode
      org-ellipsis " …")

;; Resize Titles and Headings
;; (require 'org-faces) 
;; (dolist (face '((org-level-1 . 1.3)
;;                  (org-level-2 . 1.2)
;;                  (org-level-3 . 1.15)
;;                  (org-level-4 . 1.1)
;;                 (org-level-5 . 1.05)))
;;   (set-face-attribute (car face) nil :height (cdr face))) ; Resize Headings
;; (set-face-attribute 'org-document-title nil :weight 'bold :height 1.3) ; Resize title

;; Beautify Lists and Stars
(setq org-list-demote-modify-bullet '(("-" . "+") ("+" . "-") ("*" . "-"))
      org-modern-list '((43 . "◦") (45 . "•") (42 . "•")) ; Respectively + - *
      org-modern-star '("◉" "○" "◈" "◇" "◉" "○"))

;; Emphasis Markers and Entities
(setq org-hide-emphasis-markers t
      org-pretty-entities t
      org-pretty-entities-include-sub-superscripts t)

;; Latex Fragments Preview
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.3)) ; Make the image a little larger

;;; Editing
;; Link
(setq org-return-follows-link t
      org-confirm-elisp-link-function nil)

;; Structure
(setq org-M-RET-may-split-line '((default . nil)) ; M-RET will not split the line
      org-special-ctrl-a/e t) ; C-a and C-e behave specially in headlines and items

;; Org startup group.
(setq org-hide-block-startup t		; Fold all blocks
      org-startup-folded 'content)	; Show contents

(provide 'init-org)
