;;; org.el --- org settings -*- lexical-binding: t; -*-

(require 'org)

(use-package org-super-agenda :ensure t)

;; Must do this so the agenda knows where to look for my files
(setq org-agenda-files '("~/org"))
(setq org-archive-location "~/org/archive.org::* Archive")

;; When a TODO is set to a done state, record a timestamp
(setq org-log-done 'time)

;; Follow the links
(setq org-return-follows-link  t)

;; Associate all org files with org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Make the indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)

;; Remap the change priority keys to use the UP or DOWN key
(define-key org-mode-map (kbd "C-c <up>") 'org-priority-up)
(define-key org-mode-map (kbd "C-c <down>") 'org-priority-down)

;; Shortcuts for storing links, viewing the agenda, and starting a capture
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

;; When you want to change the level of an org item, use SMR
(define-key org-mode-map (kbd "C-c C-g C-r") 'org-shiftmetaright)

;; Hide the markers so you just see bold text as BOLD-TEXT and not *BOLD-TEXT*
(setq org-hide-emphasis-markers t)

;; Wrap the lines in org mode so that things are easier to read
(add-hook 'org-mode-hook 'visual-line-mode)

;; styling
(let* ((variable-tuple
        (cond ((x-list-fonts "Fira Code") '(:font "Fira Code"))
              (nil (warn "Cannot find Fira Code font."))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces
   'user
   `(org-level-8 ((t (,@headline ,@variable-tuple))))
   `(org-level-7 ((t (,@headline ,@variable-tuple))))
   `(org-level-6 ((t (,@headline ,@variable-tuple))))
   `(org-level-5 ((t (,@headline ,@variable-tuple))))
   `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
   `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.2))))
   `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.3))))
   `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.5))))
   `(org-document-title ((t (,@headline ,@variable-tuple :height 1.8 :underline nil))))))

(setq org-capture-templates
      '(("i" "Inbox"
         entry (file+headline "~/org/inbox.org" "Inbox")
         "* CLARIFY %?\n"
         :empty-lines 0)
        ("j" "Daily Log Entry"
         entry (file+datetree "~/org/daily-log.org")
         "* %?"
         :empty-lines 0)
        ("g" "General Todo"
         entry (file+headline "~/org/todos.org" "General Tasks")
         "* TODO %?\n"
         :empty-lines 0)
        ("c" "Code To-Do"
         entry (file+headline "~/org/todos.org" "Code Related Tasks")
         "* TODO %?\n%i\n%a\nProposed Solution: "
         :empty-lines 0)
        ("m" "Meeting"
         entry (file+datetree "~/org/meetings.org")
         "* %? :meeting:%^g \n** Attendees\n*** \n** Notes\n** Action Items\n*** TODO "
         :tree-type week
         :clock-in t
         :clock-resume t
         :empty-lines 0)
        ))

;; todo states
(setq org-todo-keywords
      '((sequence "CLARIFY(c)" "TODO(t)" "NEXT(n)" "INPROGRESS(i@/!)" "VERIFYING(v!)" "BLOCKED(b@)" "|" "DONE(d!)" "OBE(o@!)" "WONTDO(w@/!)")))

;; todo colors
(setq org-todo-keyword-faces
      '(
        ("CLARIFY" . (:foreground "violet" :weight bold))
        ("TODO" . (:foreground "GoldenRod" :weight bold))
        ("NEXT" . (:foreground "Purple" :weight bold))
        ("INPROGRESS" . (:foreground "Cyan" :weight bold))
        ("VERIFYING" . (:foreground "DarkOrange" :weight bold))
        ("BLOCKED" . (:foreground "Red" :weight bold))
        ("DONE" . (:foreground "LimeGreen" :weight bold))
        ("OBE" . (:foreground "LimeGreen" :weight bold))
        ("WONTDO" . (:foreground "LimeGreen" :weight bold))
        ))

(setq org-refile-targets '((org-agenda-files :maxlevel . 1)))

;; tags
(setq org-tag-alist '(
                      ;; ticket types
                      (:startgroup . nil)
                      ("@feature" . ?u)
                      ("@spike" . ?j)
                      ("@bug" . ?b)
                      (:endgroup . nil)

                      ;; meeting types
                      (:startgroup . nil)
                      ("calibration" . ?c)
                      ("standup" . ?s)
                      ("1x1" . ?1)
                      ("retro" . ?r)
                      (:endgroup . nil)
                      ))
