;;; -*- lexical-binding: t -*-

(defun tangle-init ()
  "If the current buffer is init.org the code-blocks are
tangled, and the tangled file is compiled."
  (when (equal (buffer-file-name)
               (expand-file-name (concat user-emacs-directory "init.org")))
    ;; Avoid running hooks when tangling.
    (let ((prog-mode-hook nil))
      (org-babel-tangle)
      (byte-compile-file (concat user-emacs-directory "init.el")))))

(add-hook 'after-save-hook 'tangle-init)

(setq org-directory "~/org/"
      org-roam-directory "~/org/roam"
      projectile-project-search-path '("~/projects/")
      user-full-name "Guillaume Labrie"
      user-mail-address "glabrie@proton.me"
      shell-file-name (executable-find "bash")
      select-enable-clipboard t)

(use-package git-auto-commit-mode)

(add-to-list 'safe-local-eval-forms '(git-auto-commit-mode 1))
(add-to-list 'safe-local-variable-values '(gac-automatically-push-p . t))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "helium")

(when (boundp 'pgtk-wait-for-event-timeout)
  (setq pgtk-wait-for-event-timeout 0.001))

(setq redisplay-skip-fontification-on-input t)

(require 'package)
  (require 'use-package)
  (require 'use-package-ensure)
  (setq use-package-always-ensure t)
  (setq package-archives
      '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
        ("MELPA"        . "https://melpa.org/packages/")
        ("ORG"          . "https://orgmode.org/elpa/")
        ("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("nongnu"       . "https://elpa.nongnu.org/nongnu/"))
      package-archive-priorities
      '(("GNU ELPA"     . 20)
        ("MELPA"        . 15)
        ("ORG"          . 10)
        ("MELPA Stable" . 5)
        ("nongnu"       . 0)))
(package-initialize)
(setq package-install-upgrade-built-in t)

(use-package meow
  :config
  (defun meow-setup ()
    (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
    (meow-motion-define-key
     '("j" . meow-next)
     '("k" . meow-prev)
     '("<escape>" . ignore))
    (meow-leader-define-key
     '("1" . meow-digit-argument)
     '("2" . meow-digit-argument)
     '("3" . meow-digit-argument)
     '("4" . meow-digit-argument)
     '("5" . meow-digit-argument)
     '("6" . meow-digit-argument)
     '("7" . meow-digit-argument)
     '("8" . meow-digit-argument)
     '("9" . meow-digit-argument)
     '("0" . meow-digit-argument)
     '("/" . meow-keypad-describe-key)
     '("?" . meow-cheatsheet))
    (meow-normal-define-key
     '("0" . meow-expand-0)
     '("9" . meow-expand-9)
     '("8" . meow-expand-8)
     '("7" . meow-expand-7)
     '("6" . meow-expand-6)
     '("5" . meow-expand-5)
     '("4" . meow-expand-4)
     '("3" . meow-expand-3)
     '("2" . meow-expand-2)
     '("1" . meow-expand-1)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     '("a" . meow-append)
     '("A" . meow-open-below)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . meow-change)
     '("d" . meow-delete)
     '("D" . meow-backward-delete)
     '("e" . meow-next-word)
     '("E" . meow-next-symbol)
     '("f" . meow-find)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("i" . meow-insert)
     '("I" . meow-open-above)
     '("j" . meow-next)
     '("J" . meow-next-expand)
     '("k" . meow-prev)
     '("K" . meow-prev-expand)
     '("l" . meow-right)
     '("L" . meow-right-expand)
     '("m" . meow-join)
     '("n" . meow-search)
     '("o" . meow-block)
     '("O" . meow-to-block)
     '("p" . meow-yank)
     '("q" . meow-quit)
     '("Q" . meow-goto-line)
     '("r" . meow-replace)
     '("R" . meow-swap-grab)
     '("s" . meow-kill)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("U" . meow-undo-in-selection)
     '("v" . meow-visit)
     '("w" . meow-mark-word)
     '("W" . meow-mark-symbol)
     '("x" . meow-line)
     '("X" . meow-goto-line)
     '("y" . meow-save)
     '("Y" . meow-sync-grab)
     '("z" . meow-pop-selection)
     '("'" . repeat)
     '("<escape>" . ignore)))
  (meow-setup)
  (meow-global-mode 1))

(use-package vertico
  :init
  (vertico-mode)
  :config
  (setq vertico-count                         20
        read-file-name-completion-ignore-case t
        read-buffer-completion-ignore-case    t
        completion-ignore-case                t))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package consult
  :bind
  ("C-s"     . consult-line)
  ("C-M-s"   . consult-ripgrep)
  ("C-x b"   . consult-buffer)
  ("C-x C-b" . consult-buffer)
  ("M-g g"   . consult-goto-line)
  ("M-g t"   . consult-imenu))

(use-package avy
  :bind
  ("C-:"   . avy-goto-char)
  ("C-'"   . avy-goto-char-2)
  ("M-g f" . avy-goto-line))

(use-package projectile
  :init
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(dolist (mode
         '(tool-bar-mode       ;; Remove toolbar
           scroll-bar-mode     ;; Remove scollbars
           menu-bar-mode))     ;; Remove menu bar
  (funcall mode 0))

(setq inhibit-startup-message           t       ;; No startup message
      inhibit-startup-echo-area-message t       ;; No startup message in echo area
      inhibit-startup-screen            t       ;; No default startup screen
      initial-buffer-choice             t       ;; *scratch* is default startup buffer
      initial-major-mode                'fundamental-mode
      ring-bell-function                'ignore ;; No bell
      display-time-default-load-average nil     ;; Don't show me load time
      scroll-margin                     0       ;; Space between top/bottom
      use-dialog-box                    nil)    ;; Disable dialog

(use-package kanagawa-themes
    :ensure t
    :config
    (load-theme 'kanagawa-wave t))

(add-to-list 'default-frame-alist '(alpha-background . 90))
(modify-all-frames-parameters '((alpha-background . 90)))

(add-to-list 'default-frame-alist '(internal-border-width . 16))

(set-fringe-mode 10)                          ;; Set fringe width to 10

(setq-default fringes-outside-margins nil)
(setq-default indicate-buffer-boundaries nil) ;; Otherwise shows a corner icon on the edge
(setq-default indicate-empty-lines nil)       ;; Otherwise there are weird fringes on blank lines

(set-face-attribute 'header-line t :inherit 'default)

(use-package nano-modeline
  :hook
  (prog-mode . nano-modeline-prog-mode)
  (text-mode . nano-modeline-text-mode)
  (org-mode  . nano-modeline-org-mode)
  :config
  (setq nano-modeline-position 'nano-modeline-footer))

(use-package org
    :ensure nil
    :config
    (setq org-startup-folded 'content
          org-auto-align-tags nil
          org-tags-column 0
          org-catch-invisible-edits 'show-and-error
          org-special-ctrl-a/e t
          org-insert-heading-respect-content t
          org-hide-emphasis-markers t
          org-pretty-entities t
          org-ellipsis " ⮯"
          org-log-done t
          org-src-content-indentation 0
          org-startup-with-inline-images t
          ;; org-startup-with-latex-preview t
          org-agenda-tags-column 0
          org-agenda-hide-tags-regexp "^todo$"
          org-agenda-block-separator ?─
          org-agenda-time-grid
          '((daily today require-timed)
            (800 1000 1200 1400 1600 1800 2000)
            " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
          org-agenda-current-time-string
          "◀── now ─────────────────────────────────────────────────"
          org-agenda-files nil
          org-archive-location "~/org/archive.org::datetree/"
          org-todo-keywords
          '((sequence "TODO" "NEXT" "DOING" "WAIT" "SOMEDAY" "|" "DONE" "DROP")))
    (require 'org-tempo))

(use-package org-modern
  :after org
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("●" "○" "◉" "◎" "◈")
        org-modern-todo nil
        org-modern-tag nil
        org-modern-timestamp nil
        org-modern-block-name t
        org-modern-keyword t
        org-modern-table t))

(use-package org-modern-indent
  :vc (:url "https://github.com/jdtsmith/org-modern-indent" :rev :newest)
  :after org-modern
  :hook (org-modern-mode . org-modern-indent-mode))

(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis   t
        org-appear-autolinks      t
        org-appear-autosubmarkers t))

(use-package svg-tag-mode
  :after org
  :hook (org-mode . svg-tag-mode)
  :config
  (defconst date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
  (defconst time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
  (defconst day-re "[A-Za-z]\\{3\\}")
  (defconst day-time-re (format "\\(%s\\)? ?\\(%s\\)?" day-re time-re))

  (defun svg-progress-percent (value)
    (svg-image (svg-lib-concat
                (svg-lib-progress-bar (/ (string-to-number value) 100.0)
                  nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                (svg-lib-tag (concat value "%")
                  nil :stroke 0 :margin 0)) :ascent 'center))

  (defun svg-progress-count (value)
    (let* ((seq (mapcar #'string-to-number (split-string value "/")))
           (count (float (car seq)))
           (total (float (cadr seq))))
      (svg-image (svg-lib-concat
                  (svg-lib-progress-bar (/ count total) nil
                    :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                  (svg-lib-tag value nil
                    :stroke 0 :margin 0)) :ascent 'center)))

  (setq svg-tag-tags
        `(;; Task priority
          ("\\[#[A-Z]\\]" . ((lambda (tag)
                               (svg-tag-make tag :face 'org-priority
                                             :beg 2 :end -1 :margin 0))))
          ;; Progress
          ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
            (svg-progress-percent (substring tag 1 -2)))))
          ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
            (svg-progress-count (substring tag 1 -1)))))
          ;; Active date
          (,(format "\\(<%s>\\)" date-re) .
           ((lambda (tag) (svg-tag-make tag :beg 1 :end -1 :margin 0))))
          (,(format "\\(<%s \\)%s>" date-re day-time-re) .
           ((lambda (tag) (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0))))
          (,(format "<%s \\(%s>\\)" date-re day-time-re) .
           ((lambda (tag) (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0))))
          ;; Inactive date
          (,(format "\\(\\[%s\\]\\)" date-re) .
           ((lambda (tag) (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))
          (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
           ((lambda (tag) (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :face 'org-date))))
          (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
           ((lambda (tag) (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :face 'org-date))))
          ("\\(:dailies:\\)" . ((lambda (_) (svg-lib-icon "shield-outline" nil :collection "material"))))
          ("\\(:learn:\\)" . ((lambda (_) (svg-lib-icon "sprout-outline" nil :collection "material"))))
          ("\\(:event:\\)" . ((lambda (_) (svg-lib-icon "calendar-clock" nil :collection "material"))))
          ("\\<\\(TODO\\)\\>" . ((lambda (tag) (svg-tag-make tag :margin 0 :face 'org-todo))))
          ("\\<\\(NEXT\\)\\>" . ((lambda (tag) (svg-tag-make tag :margin 0 :face 'org-todo))))
          ("\\<\\(DOING\\)\\>" . ((lambda (tag) (svg-tag-make tag :margin 0 :face 'org-todo))))
          ("\\<\\(WAIT\\)\\>" . ((lambda (tag) (svg-tag-make tag :margin 0 :face 'shadow))))
          ("\\<\\(SOMEDAY\\)\\>" . ((lambda (tag) (svg-tag-make tag :margin 0 :face 'shadow))))
          ("\\<\\(DONE\\)\\>" . ((lambda (tag) (svg-tag-make tag :margin 0 :face 'org-done))))
          ("\\<\\(DROP\\)\\>" . ((lambda (tag) (svg-tag-make tag :margin 0 :face 'org-done)))))))

(defun org-agenda-show-svg ()
  (let* ((case-fold-search nil)
         (keywords (mapcar #'svg-tag--build-keywords svg-tag--active-tags))
         (keyword (car keywords)))
    (while keyword
      (save-excursion
        (while (re-search-forward (nth 0 keyword) nil t)
          (overlay-put (make-overlay
                        (match-beginning 0) (match-end 0))
                       'display (nth 3 (eval (nth 2 keyword))))))
      (pop keywords)
      (setq keyword (car keywords)))))
(add-hook 'org-agenda-finalize-hook #'org-agenda-show-svg)

(use-package mixed-pitch
  :hook ((org-mode   . mixed-pitch-mode)
         (LaTeX-mode . mixed-pitch-mode)))

(use-package olivetti
  :hook (org-mode . olivetti-mode)
  :config
  (setq-default olivetti-body-width 225))

(with-eval-after-load 'org
  (plist-put org-format-latex-options :scale 1.35)
  (let ((png (cdr (assoc 'dvipng org-preview-latex-process-alist))))
    (plist-put png :latex-compiler '("latex -interaction nonstopmode -output-directory %o %F"))
    (plist-put png :image-converter '("dvipng -D %D -T tight -o %O %F"))
    (plist-put png :transparent-image-converter '("dvipng -D %D -T tight -bg Transparent -o %O %F"))))

(use-package org-fragtog
  :after org
  :hook (org-mode . org-fragtog-mode))

(use-package org-super-agenda
  :after org
  :config
  (org-super-agenda-mode)
  (setq org-super-agenda-groups
        '((:name "Overdue"
                 :deadline past)
          (:name "Doing"
                 :todo "DOING")
          (:name "Dailies"
                 :tag "dailies")
          (:name "Next"
                 :todo "NEXT")
          (:name "Events"
                 :tag "event")
          (:name "Learn"
                 :tag "learn")
          (:name "Waiting"
                 :todo "WAIT")
          (:name "Someday"
                 :todo "SOMEDAY")
          (:name "Inbox"
                 :todo "TODO"))))

(use-package org-roam
  :config
  (org-roam-db-autosync-mode))

(use-package org-roam-ui)

(with-eval-after-load 'org
  (setq org-capture-templates
    '(("f" "Fleeting Note" entry
       (file+headline
        (lambda ()
          (expand-file-name
           (format-time-string "%Y-%m-%d.org")
           (expand-file-name org-roam-dailies-directory org-roam-directory)))
        "Fleeting Notes")
       "** %?"
       :empty-lines 1)
      ("q" "Daily Quest" entry
       (file+headline
        (lambda ()
          (expand-file-name
           (format-time-string "%Y-%m-%d.org")
           (expand-file-name org-roam-dailies-directory org-roam-directory)))
        "Daily Quests")
       "** TODO %? :dailies:\nSCHEDULED: %(format-time-string \"<%Y-%m-%d>\")"
       :empty-lines 1)
      ("e" "Event" entry
       (file+headline
        (lambda ()
          (expand-file-name
           (format-time-string "%Y-%m-%d.org")
           (expand-file-name org-roam-dailies-directory org-roam-directory)))
        "Added to the agenda today")
       "** %? %^T :event:"
       :empty-lines 1))))

(defun roam-extra:get-filetags ()
  (split-string (or (org-roam-get-keyword "filetags") "")))

(defun roam-extra:add-filetag (tag)
  (let* ((new-tags (cons tag (roam-extra:get-filetags)))
         (new-tags-str (combine-and-quote-strings new-tags)))
    (org-roam-set-keyword "filetags" new-tags-str)))

(defun roam-extra:del-filetag (tag)
  (let* ((new-tags (seq-difference (roam-extra:get-filetags) `(,tag)))
         (new-tags-str (combine-and-quote-strings new-tags)))
    (org-roam-set-keyword "filetags" new-tags-str)))

(defun roam-extra:todo-p ()
  (org-element-map
      (org-element-parse-buffer 'headline)
      'headline
    (lambda (h)
      (eq (org-element-property :todo-type h) 'todo))
    nil 'first-match))

(defun roam-extra:update-todo-tag ()
  (when (and (featurep 'org-roam)
             (not (active-minibuffer-window))
             (org-roam-file-p))
    (org-with-point-at 1
      (let* ((tags (roam-extra:get-filetags))
             (is-todo (roam-extra:todo-p)))
        (cond ((and is-todo (not (seq-contains-p tags "todo")))
               (roam-extra:add-filetag "todo"))
              ((and (not is-todo) (seq-contains-p tags "todo"))
               (roam-extra:del-filetag "todo")))))))

(defun roam-extra:todo-files ()
  (org-roam-db-sync)
  (let ((todo-nodes (seq-filter (lambda (n)
                                  (seq-contains-p (org-roam-node-tags n) "todo"))
                                (org-roam-node-list))))
    (seq-uniq (seq-map #'org-roam-node-file todo-nodes))))

(defun roam-extra:update-todo-files (&rest _)
  (setq org-agenda-files (roam-extra:todo-files)))

(add-hook 'find-file-hook #'roam-extra:update-todo-tag)
(add-hook 'before-save-hook #'roam-extra:update-todo-tag)
(advice-add 'org-agenda :before #'roam-extra:update-todo-files)

(with-eval-after-load 'org-roam
  (require 'org-roam-ui)
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))
          ("w" "weekly review" entry
           "* %<%Y-W%V> Weekly review                                  :weekly:
[[id:WEEKLY-REVIEW-NODE-ID][Weekly Review]]

** Review checklist
,- [ ] Review each daily note
,- [ ] Fleeting notes -> Permanent notes
,- [ ] Refile to archive DONE and DROP todos
,- [ ] Physical inbox -> Paperless

** Summary of the week
%?

** Wins

** Misses

** What to keep in mind moving forward

** Planning the next: What needs doing?
"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))))

(defun my/daily-setup ()
  (interactive)
  (org-roam-dailies-goto-today "d")
  (save-excursion
    (goto-char (point-min))
    (unless (search-forward "* Morning Pages" nil t)
      (goto-char (point-max))
      (unless (bolp) (insert "\n"))
      (insert (concat "* Morning Pages\n\n"
                      "* Daily Quests\n\n"
                      "* Added to the agenda today\n\n"
                      "* Habits\n"
                      "** Morning routine\n"
                      "- [ ] Drink a glass of water\n"
                      "- [ ] Take meds\n"
                      "- [ ] Healthy breakfast\n"
                      "- [ ] Beeline the sun, 15 minutes walk\n"
                      "- [ ] Morning exercises and stretching\n"
                      "- [ ] Cold shower\n"
                      "- [ ] Read 20 mins\n"
                      "- [ ] Journal and prepare the day\n\n"
                      "** Evening routine\n"
                      "- [ ] 30-min walk\n"
                      "- [ ] Before bed, 3 2 1. 3 hours before no food, 2 no water and 1 no screens\n"
                      "- [ ] Review of the day, journal, prepare the next\n"
                      "- [ ] Read some more\n\n"
                      "* Evening review\n\n"
                      "* Fleeting Notes\n")))))

(defun my/batch-promote-quests ()
  "Convert bare headings under Daily Quests into TODO items scheduled for today."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^\\* Daily Quests" nil t)
      (beginning-of-line)
      (org-map-entries
       (lambda ()
         (when (and (= (org-outline-level) 2)
                    (not (org-get-todo-state)))
           (org-todo "TODO")
           (org-schedule nil (format-time-string "%Y-%m-%d"))
           (org-toggle-tag "dailies" 'on)))
       nil 'tree))))

(defconst +my/org-capture-frame-name "Org-capture to daily note")
(defun +my/org-capture-frame (template) (interactive)
       (if (not (equal +my/org-capture-frame-name (frame-parameter nil 'name)))
           (make-frame `((name . ,+my/org-capture-frame-name))))

       (select-frame-by-name +my/org-capture-frame-name)
       (delete-other-windows)

       (defun org-capture-after-finalize-cleanup ()
         (advice-remove 'org-capture-place-template 'delete-other-windows)
         (remove-hook 'org-capture-after-finalize-hook 'org-capture-after-finalize-cleanup)

         (select-frame-by-name +my/org-capture-frame-name)
         (delete-frame nil))

       (add-hook 'org-capture-after-finalize-hook 'org-capture-after-finalize-cleanup)
       (advice-add #'org-capture-place-template :after 'delete-other-windows)

       (org-capture nil template))
