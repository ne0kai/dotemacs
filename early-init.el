;;; early-init.el --- Early initialization.

;; Emacs 27 introduces early-init.el, which is run before init.el,
;; before package and UI initialization happens.

; Defer garbage collection further back in the startup process
(setq gc-cons-threshold most-positive-fixnum)

;; Use straight.el instead
(setq package-enable-at-startup nil)

;; In noninteractive sessions, prioritize non-byte-compiled source files to
;; prevent the use of stale byte-code. Otherwise, it saves us a little IO time
;; to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

;; Supress native compilation warnings
(setq native-comp-async-report-warnings-errors 'silent)

;; Inhibit resizing frame
(setq frame-inhibit-implied-resize t)

;; Default frame settings
(setq default-frame-alist
      (append (list
               '(min-height . 1)  '(height . 40)
               '(min-width  . 1)  '(width  . 120)
               '(internal-border-width . 12)
               '(left-fringe . 12)
               '(right-fringe . 12))))

;; Faster to disable these here (before they've been initialized)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
