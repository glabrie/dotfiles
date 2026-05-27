;;; -*- lexical-binding: t -*-

;; Defer garbage collection
(setq gc-cons-percentage 0.6)

;; Change default max size for reading processes (like LSP mode)
(setq read-process-output-max (* 4 1024 1024)) ;; 4mb

(set-language-environment "UTF-8")

;; Set-language-environment sets default-input-method, which is unwanted.
(setq default-input-method nil)

;; Prefer loading newer compiled files
(setq load-prefer-newer t)

;; Prevent the glimpse of un-styled Emacs by disabling these UI elements early.
(setq default-frame-alist
      '((vertical-scroll-bars . nil)
        (menu-bar-lines       . 0)
        (tool-bar-lines       . 0)))

(setq default-frame-scroll-bars 'right)
(setq scroll-bar-mode nil)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise       t)

;; Font compacting can be very resource-intensive, especially when rendering
;; icon fonts on Windows. This will increase memory usage.
(setq inhibit-compacting-font-caches t)

;; Ignore X resources; its settings would be redundant with the other settings
;; in this file and can conflict with later config (particularly where the
;; cursor color is concerned).
(advice-add #'x-apply-session-resources :override #'ignore)

;; A second, case-insensitive pass over `auto-mode-alist' is time wasted.
;; No second pass of case-insensitive search over auto-mode-alist.
(setq auto-mode-case-fold nil)

;; Disable bidirectional text scanning for a modest performance boost.
(setq-default bidi-display-reordering  'left-to-right
              bidi-paragraph-direction 'left-to-right)

;; Give up some bidirectional functionality for slightly faster re-display.
(setq bidi-inhibit-bpa t)

;; In PGTK, this timeout introduces latency. Reducing it from the default 0.1
;; improves responsiveness of childframes and related packages.
(when (boundp 'pgtk-wait-for-event-timeout)
  (setq pgtk-wait-for-event-timeout 0.001))

;; Disable warnings from the legacy advice API. They aren't useful.
(setq ad-redefinition-action 'accept)

;; Font compacting can be very resource-intensive, especially when rendering
;; icon fonts on Windows. This will increase memory usage.
(setq inhibit-compacting-font-caches t)

;; Unset `file-name-handler-alist' too (temporarily). Every file opened and
;; loaded by Emacs will run through this list to check for a proper handler for
;; the file, but during startup, it won’t need any of them.
(defvar file-name-handler-alist-old file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist file-name-handler-alist-old)))

;; For LSP mode, use plists for deserialization
;; For more info, see https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
(setenv "LSP_USE_PLISTS" "true")

;; Remove "For information about GNU Emacs..." message at startup
(advice-add #'display-startup-echo-area-message :override #'ignore)

;; Suppress the vanilla startup screen completely. Even if disabled with
;; `inhibit-startup-screen', it would still initialize anyway.
(advice-add #'display-startup-screen :override #'ignore)

;; Shave seconds off startup time by starting the scratch buffer in
;; `fundamental-mode'
(setq initial-major-mode 'fundamental-mode
      initial-scratch-message nil)

;; Disable startup screens and messages
(setq inhibit-splash-screen t)
