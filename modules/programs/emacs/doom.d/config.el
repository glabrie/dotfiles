(setq
        shell-file-name "/etc/profiles/per-user/ghil/bin/zsh"
        org-directory "~/org/"
        org-roam-directory "~/org/roam"
        projectile-project-search-path '("~/projects/")
        user-full-name "Guillaume Labrie"
        user-mail-address "glabrie@proton.me"

doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18)
        doom-variable-pitch-font (font-spec :family "Montserrat" :size 20)
        doom-serif-font          (font-spec :family "JetBrainsMono Nerd Font" :size 18)
        doom-theme 'doom-tokyo-night                                    ;; Theme, I expect to change in three days, like always
        display-line-numbers-type 'relative)                             ;; You can take the man from the Vim

(add-to-list 'default-frame-alist '(alpha-background . 80))
(set-frame-parameter nil 'alpha-background 80)

(global-display-line-numbers-mode +1)                                   ;; But you can't take the vim from the man

(map! :leader
      :desc "Capture daily" "n d" #'org-roam-dailies-capture-today
      :desc "Go to daily" "n D" #'org-roam-dailies-goto-today
      :desc "Org-roam UI graph" "n r g" #'org-roam-ui-mode)

;; org-modern configuration + a dirty fix for TODOs in roam not showing up outside in the todo list.
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
        "◀── now ─────────────────────────────────────────────────"
        org-agenda-files
          (directory-files-recursively org-directory "\\.org$"))
;; Let's activate it now
(global-org-modern-mode))


(after! org-roam
  (require 'org-roam-ui)
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; Dedicated org-capture frame, adapted from https://gist.github.com/progfolio/af627354f87542879de3ddc30a31adc1
(defun +my/org-roam-capture-fullscreen (orig-fn &rest args)
  "Run ORIG-FN fullscreen when invoked from the dedicated \"org-capture\" frame.
Elsewhere, behave normally."
  (if (equal (frame-parameter nil 'name) "org-capture")
      (progn
        (require 'cl-lib)
        (delete-other-windows)
        (cl-letf (((symbol-function 'switch-to-buffer-other-window) #'switch-to-buffer))
          (condition-case err
              (apply orig-fn args)
            (user-error (when (string= (cadr err) "Abort")
                          (delete-frame))))))
    (apply orig-fn args)))
(advice-add 'org-roam-dailies-capture-today
            :around #'+my/org-roam-capture-fullscreen)

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

;; mixed-pitch stays enabled (default) so prose uses Montserrat and code stays mono.

;; Force eager fontification so org source-block faces apply across the whole
;; block instead of only where the cursor has been — visible when alpha-background
;; is on and a block's tinted bg is missing.
(setq jit-lock-defer-time nil
      jit-lock-chunk-size 4096)

;; Don't let mixed-pitch force variable-pitch to match the default face's
;; height — we want Montserrat slightly larger to compensate for its smaller
;; x-height vs JetBrains Mono.
(after! mixed-pitch
  (setq mixed-pitch-set-height nil))

;; Always-on mixed-pitch in text/org buffers (the :ui zen hook isn't reliably
;; firing for unknown reasons — wire it explicitly).
(add-hook 'text-mode-hook #'mixed-pitch-mode)

;; Open links in Zen via the system browser (browse-url breaks under daemon mode without explicit config)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "zen")

;; Use mu4e's built-in modeline; suppress the legacy doom-modeline mu4e segment
(after! doom-modeline
  (setq doom-modeline-mu4e nil))
