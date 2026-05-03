(setq shell-file-name "/etc/profiles/per-user/ghil/bin/zsh"
      org-directory "~/org/"
      org-roam-directory "~/org/roam"
      projectile-project-search-path '("~/projects/")
      user-full-name "Guillaume Labrie"
      user-mail-address "glabrie@proton.me")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "Montserrat")
      doom-symbol-font (font-spec :family "JetBrainsMono Nerd Font" :size 18)
      doom-big-font (font-spec :family "Maple Mono NF" :size 24))

(setq doom-theme 'doom-tokyo-night)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)

(modify-all-frames-parameters
 '((right-divider-width . 12)
   (internal-border-width . 12)))
(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))
(set-face-background 'fringe (face-attribute 'default :background))

(add-to-list 'default-frame-alist '(alpha-background . 80))
(set-frame-parameter nil 'alpha-background 80)

(after! org
  (setq org-auto-align-tags nil
        org-tags-column 0
        org-catch-invisible-edits 'show-and-error
        org-special-ctrl-a/e t
        org-insert-heading-respect-content t
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-ellipsis " ⮯"
        org-agenda-tags-column 0
        org-agenda-block-separator ?─
        org-agenda-time-grid
        '((daily today require-timed)
          (800 1000 1200 1400 1600 1800 2000)
          " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
        org-agenda-current-time-string
        "◀── now ─────────────────────────────────────────────────"
        org-agenda-files
          (directory-files-recursively org-directory "\\.org$")))

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        org-modern-block-fringe nil))

(add-hook 'text-mode-hook #'mixed-pitch-mode)

(map! :leader
      :desc "Capture daily" "n d" #'org-roam-dailies-capture-today
      :desc "Go to daily" "n D" #'org-roam-dailies-goto-today
      :desc "Org-roam UI graph" "n r g" #'org-roam-ui-mode)

(after! org-roam
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

** Summary of the week
%?

** Wins

** Misses

** What to keep in mind moving forward

** Planning the next: What needs doing?
"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))))

(defun +my/org-capture-fullscreen-in-dedicated-frame (&rest _)
  (when (equal (frame-parameter nil 'name) "org-capture")
    (delete-other-windows)))
(add-hook 'org-capture-mode-hook #'+my/org-capture-fullscreen-in-dedicated-frame)
(advice-add 'org-roam-dailies-capture-today
            :after #'+my/org-capture-fullscreen-in-dedicated-frame)

(defun +my/org-capture-cleanup-frame (&rest _)
  (when (equal (frame-parameter nil 'name) "org-capture")
    (delete-frame)))
(advice-add 'org-capture-finalize :after #'+my/org-capture-cleanup-frame)

(add-hook '+doom-dashboard-inhibit-functions
          (lambda () (equal (frame-parameter nil 'name) "org-capture")))

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
        shr-use-colors nil))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "zen")
