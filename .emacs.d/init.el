;;; init.el --- Emacs Configuration

;;; Commentary:
;; Modular Emacs config for IC design + C/C++ development
;; Ubuntu 22.04 optimized

;;; Code:

;; =================================================================
;; Early Setup
;; =================================================================

;; Increase GC threshold during startup for faster load
(setq gc-cons-threshold (* 50 1024 1024))  ; 50MB
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1024 1024))))  ; restore to 2MB

;; Native compilation cache (if available)
(when (boundp 'native-comp-eln-load-path)
  (setq native-comp-async-report-warnings-errors nil))

;; =================================================================
;; Custom File (keep Customize variables out of init.el)
;; =================================================================
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file t nil t)

;; =================================================================
;; Package Management
;; =================================================================
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Ensure package list is populated (needed for first install)
(when (not package-archive-contents)
  (package-refresh-contents))

;; Suppress deprecated package warnings from old third-party libs
(setq byte-compile-warnings '(cl-functions))
(setq warning-suppress-types '((package cl)))

;; =================================================================
;; External Tools Path
;; =================================================================
(defconst my/site-lisp-dir (expand-file-name "site-lisp/" user-emacs-directory))
(add-to-list 'load-path my/site-lisp-dir)

;; =================================================================
;; Load Modules
;; =================================================================

(add-to-list 'load-path (expand-file-name "lisp/" user-emacs-directory))

(require 'init-basic)      ; basic behavior, clipboard, history
(require 'init-ui)         ; appearance, theme, fonts
(require 'init-editing)    ; editing helpers, indent, pairs
(require 'init-completion) ; company mode
(require 'init-lang)       ; language modes (C/C++, Verilog, etc.)
(require 'init-keys)       ; key bindings
(require 'init-shell)      ; shell management
(require 'init-tools)      ; dired, gdb, misc tools

;; =================================================================
;; Session & Startup
;; =================================================================

;; Desktop session
(require 'desktop)
(desktop-read)

(provide 'init)
;;; init.el ends here
