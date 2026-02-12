;;; init-journal.el

(require 'init-notes) ;; for my-writing-mode

;; journal directory

(setq journal-dir "~/mind/timeline/daily/")

;; journal entry
(defun my-journal-entry ()
  "Open today's journal file and insert a new entry with the current time.
If the file is new, insert a title header."
  (interactive)
  (let* ((date (format-time-string "%Y-%m-%d"))           ; Get today's date
         (weekday (format-time-string "%A"))
         (filename (concat journal-dir date ".md"))  ; Build the filename
         (time (format-time-string "\n\n## %H:%M "))         ; Format the time as '## hh:mm'
         (new-file (not (file-exists-p filename)))) ; Check if file is new
    
    ;; Open the file and insert the journal entry at the end
    (find-file filename)
    (my-writing-mode)
    (when new-file
      (insert (format "# %s %s" date weekday))) ; Insert header if new
    (goto-char (point-max))   ; Go to the end of the file
    (insert time)             ; Insert the formatted time entry
    (evil-insert-state)))

(global-set-key (kbd "C-c j") #'my-journal-entry)

;; Integration with Calendar
;; refer to https://www.emacswiki.org/emacs/PersonalDiary

(define-key calendar-mode-map "j" 'journal-read-entry)

(defun journal-read-entry () "Open journal entry for selected date for viewing"
  (interactive)
  (let* ((date (calendar-cursor-to-date))
         (year (nth 2 date))
         (month (nth 0 date))
         (day (nth 1 date))
         (week (calendar-day-name date))
         (formated-date (format "%04d-%02d-%02d" year month day))
         (filename (concat journal-dir formated-date ".md")))
    (if (file-exists-p filename)
        (find-file-other-window filename)
      (find-file-other-window filename)
      (insert (format "# %s %s" formated-date week))
      )))

(provide 'init-journal)
