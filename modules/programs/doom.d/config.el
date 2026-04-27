(setq
        ;; Directories and shells
        shell-file-name "/etc/profiles/per-user/ghil/bin/zsh"           ;; Because Nushell in Emacs is hell
        org-directory "~/org/"                                          ;; Notes directory for org-mode
        org-roam-directory "~/org/roam"                                 ;; But what about second org-mode?
        projectile-project-search-path '("~/projects/")                ;; Coding Projects directory

        ;; User ID
        user-full-name "Guillaume Labrie"                               ;; My..name...
        user-mail-address "glabrie@proton.me"                           ;; My..email...address...

        ;; Display, themes, fonts
        doom-font (font-spec :family "Maple Mono NF" :size 18)          ;; Font settings, using Maple Mono because it is BEAUTIFUL
        doom-theme 'doom-tokyo-night                                    ;; Theme, I expect to change in three days, like always
        display-line-numbers-type 'relative                             ;; You can take the man from the Vim

        )

(global-display-line-numbers-mode +1)                                   ;; But you can't take the vim from the man

(use-package! org-auto-tangle                                           ;; Auto-tangle, to tangle auto-magically!
  :hook (org-mode . org-auto-tangle-mode))

;; org-modern configuration
(after! org
  (setq org-auto-align-tags nil
        org-tags-column 0
        org-catch-invisible-edits 'show-and-error
        org-special-ctrl-a/e t
        org-insert-heading-respect-content t
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-ellipsis "…"
        org-agenda-tags-column 0
        org-agenda-block-separator ?─
        org-agenda-time-grid
        '((daily today require-timed)
          (800 1000 1200 1400 1600 1800 2000)
          " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
        org-agenda-current-time-string
        "◀── now ─────────────────────────────────────────────────")
;; Let's activate it now
(global-org-modern-mode))

(map! :leader
      :desc "Capture daily" "n d" #'org-roam-dailies-capture-today
      :desc "Go to daily" "n D" #'org-roam-dailies-goto-today)

(after! mu4e
  (setq mu4e-update-interval 120
        mu4e-change-filenames-when-moving t
        mu4e-trash-folder "/Trash"
        mu4e-sent-folder "/Sent"
        mu4e-drafts-folder "/Drafts"
        mu4e-refile-folder "/Archive"
        mu4e-personal-addresses '("glabrie@proton.me" "ghil@hey.com" "glabrie85@gmail.com")
        mu4e-view-prefer-html t
        shr-max-image-proportion 0.0
        shr-color-visible-luminance-min 80
        shr-use-colors nil)
  (mu4e-alert-enable-mode-line-display))
