;;; init-ui.el --- UI, theme, fonts, appearance

;;; Commentary:
;; Visual settings: theme, fonts, mode line, cursor, window title

;;; Code:

;; CUA Mode (Windows-style editing keys)
(cua-mode t)

;; Doom Modeline: modern mode line with VCS, position and mode information.
;; Emacs 26 cannot use the current Doom Modeline release (its `compat'
;; dependency requires newer Emacs), so this setup pins compatible v3.0.0.
(require 'doom-modeline)

;; Show the Git branch in shell buffers too.  The built-in `vcs' segment
;; only knows about the visited file; a shell buffer has no buffer-file-name.
(doom-modeline-def-segment my-shell-vcs
  "Display the Git branch for a shell buffer's `default-directory'."
  (when (and (eq major-mode 'shell-mode)
             (executable-find "git")
             (locate-dominating-file default-directory ".git"))
    (let ((branch (string-trim
                   (shell-command-to-string
                    (format "git -C %s branch --show-current 2>/dev/null"
                            (shell-quote-argument default-directory))))))
      (when (> (length branch) 0)
        (concat " Git:" branch " ")))))

;; Add the shell-specific branch segment after the normal VC segment.
(doom-modeline-def-modeline 'main
  '(bar workspace-name window-number modals matches buffer-info remote-host buffer-position word-count parrot selection-info)
  '(objed-state misc-info persp-name battery grip irc mu4e gnus github debug lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs my-shell-vcs checker))

(setq doom-modeline-height 32
      ;; Do not suppress segments in narrower windows.
      doom-modeline-window-width-limit nil
      doom-modeline-buffer-file-name-style 'truncate-upto-root
      ;; Icon fonts are not installed on this host; keep the display clean.
      doom-modeline-icon nil
      doom-modeline-unicode-fallback t
      doom-modeline-minor-modes t
      doom-modeline-buffer-encoding t
      ;; Show indentation width/style when relevant.
      doom-modeline-indent-info t)
(doom-modeline-mode 1)
;; Re-apply the main modeline after all packages and local modes initialize.
(doom-modeline-set-main-modeline t)
(force-mode-line-update t)

;; Keep the requested 24-hour clock, but render it as the final segment.
;; This avoids `misc-info' placing the clock earlier in the modeline.
(doom-modeline-def-segment my-time
  "Display the current time at the far right of the mode-line."
  (propertize (format-time-string "%H:%M") 'face 'mode-line))

(setq display-time-24hr-format t
      display-time-format "%H:%M"
      display-time-default-load-average nil)
(display-time-mode -1)
(setq global-mode-string nil)
(doom-modeline-def-modeline 'main
  '(bar workspace-name window-number modals matches buffer-info remote-host buffer-position word-count parrot selection-info)
  '(objed-state misc-info persp-name battery grip irc mu4e gnus github debug lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs my-shell-vcs checker my-time))
(doom-modeline-def-segment my-project
  "Display the current Git project name when available."
  (when-let ((root-dir (locate-dominating-file default-directory ".git")))
    (concat " Project:"
            (file-name-nondirectory (directory-file-name root-dir))
            " ")))

;; Add recommended project and diagnostics indicators before the clock.
(doom-modeline-def-modeline 'main
  '(bar workspace-name window-number modals matches buffer-info remote-host buffer-position word-count parrot selection-info)
  '(objed-state misc-info persp-name battery grip irc mu4e gnus github debug lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs my-shell-vcs my-project checker my-time))
(force-mode-line-update t)
(add-to-list 'display-buffer-alist
             '("\\*Buffer List\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)
               (window-width . 0.5)))

;; UI elements
(menu-bar-mode -1)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(column-number-mode t)
(global-display-line-numbers-mode -1)
(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'display-line-numbers-mode))
(temp-buffer-resize-mode 1)

;; Editing helpers
(show-paren-mode 1)
(electric-pair-mode t)
(global-auto-revert-mode t)

;; Cursor
(set-cursor-color "#88c0d0")
(blink-cursor-mode 0)

;; Fira Code is installed in the user font directory and is used for GUI frames.
(defconst my/gui-font-family "Fira Code"
  "Default font family used by graphical Emacs frames.")
(defconst my/gui-font-height 160
  "Default graphical font height in tenths of a point.")
(add-to-list 'default-frame-alist
             `(font . ,(format "%s-16" my/gui-font-family)))
(add-to-list 'default-frame-alist `(font-backend . "xft"))
(when (display-graphic-p)
  (set-face-attribute 'default nil
                      :family my/gui-font-family
                      :height my/gui-font-height
                      :weight 'normal))

;; Chinese font fallback
(defvar my/chinese-font "Noto Sans CJK SC"
  "Fallback Chinese font.")

(defun my/set-font-fallbacks ()
  "Set up Chinese font fallbacks."
  (when (display-graphic-p)
    (dolist (charset '(kana han cjk-misc bopomofo symbol))
      (set-fontset-font t charset (font-spec :family my/chinese-font)))))

(my/set-font-fallbacks)
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (when (display-graphic-p frame)
              (my/set-font-fallbacks))))

;; Font zoom keys
(global-set-key (kbd "C-=") (lambda () (interactive)
                                (let ((ht (face-attribute 'default :height)))
                                  (set-face-attribute 'default nil :height (+ ht 10)))))
(global-set-key (kbd "C--") (lambda () (interactive)
                                (let ((ht (face-attribute 'default :height)))
                                  (set-face-attribute 'default nil :height (- ht 10)))))

;; Window title: show hostname and IP
(defvar my/server-ip nil
  "Cached primary IP address of this server.")

(defun my/get-server-ip ()
  "Return the primary IP address of this machine."
  (or my/server-ip
      (setq my/server-ip
            (string-trim
             (shell-command-to-string
              "hostname -I 2>/dev/null | awk '{print $1}'")))))

(defvar my/tty-device nil
  "Terminal device path for writing title escape sequences.")

(defun my/init-tty-and-title ()
  "Detect terminal device and set window title with hostname + IP."
  (setq my/tty-device (terminal-name))
  (let ((title (format "Emacs@%s — %s" (system-name) (my/get-server-ip))))
    (setq frame-title-format title)
    (when my/tty-device
      (ignore-errors
        (write-region (format "\033]0;%s\007" title)
                      nil my/tty-device nil 'silent)))))

(add-hook 'after-init-hook #'my/init-tty-and-title)

;; =================================================================
;; Theme System
;; =================================================================

;; ANSI color palette (for shell/term)
(setq ansi-color-names-vector
      ["black" "tomato" "PaleGreen2" "gold1"
       "DeepSkyBlue1" "MediumOrchid1" "cyan" "white"])

;; Available themes catalog: (symbol  label  style)
;; ★ = 个人推荐  ◆ = 经典流行
(defvar my/themes
  '(
    ;; ---- Dracula family ----
    (dracula           "Dracula ★"              dark)

    ;; ---- Doom themes (精选) ----
    (doom-one          "Doom One ★◆"            dark)
    (doom-dracula      "Doom Dracula"           dark)
    (doom-monokai-pro  "Doom Monokai Pro ◆"     dark)
    (doom-molokai      "Doom Molokai ◆"         dark)
    (doom-nord         "Doom Nord"              dark)
    (doom-palenight    "Doom Palenight"         dark)
    (doom-snazzy       "Doom Snazzy"            dark)
    (doom-vibrant      "Doom Vibrant"           dark)
    (doom-tokyo-night  "Doom Tokyo Night ★"     dark)
    (doom-horizon      "Doom Horizon"           dark)
    (doom-oceanic-next "Doom Oceanic Next"      dark)
    (doom-material     "Doom Material"          dark)
    (doom-solarized-dark "Doom Solarized Dark"  dark)
    (doom-spacegrey    "Doom Spacegrey"         dark)
    (doom-outrun-electric "Doom Outrun Electric" dark)
    (doom-laserwave    "Doom Laserwave"         dark)
    (doom-moonlight    "Doom Moonlight"         dark)
    (doom-challenger-deep "Doom Challenger Deep" dark)
    (doom-dark+        "Doom Dark+"             dark)
    (doom-henna        "Doom Henna"             dark)
    (doom-pine         "Doom Pine"              dark)
    ;; Doom light variants
    (doom-one-light    "Doom One Light"         light)
    (doom-flatwhite    "Doom Flatwhite"         light)
    (doom-solarized-light "Doom Solarized Light" light)
    (doom-acario-light "Doom Acario Light"      light)

    ;; ---- Nord family ----
    (nord              "Nord ★"                 dark)

    ;; ---- Gruvbox ----
    (gruvbox           "Gruvbox Dark ◆"         dark)
    (gruvbox-light     "Gruvbox Light"          light)

    ;; ---- Spacemacs ----
    (spacemacs-dark    "Spacemacs Dark"         dark)
    (spacemacs-light   "Spacemacs Light"        light)

    ;; ---- 经典独立主题 ----
    (zenburn           "Zenburn ◆"              dark)
    (solarized-dark    "Solarized Dark ◆"       dark)
    (solarized-light   "Solarized Light"        light)
    (monokai           "Monokai ◆"              dark))
  "Theme catalog: (symbol label style).")

(defun my/load-theme (theme)
  "Safely load THEME, disabling all others first."
  (interactive)
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t)
  (message "Theme: %s" theme))

(defun my/switch-theme ()
  "Interactively switch theme using completing-read."
  (interactive)
  (let* ((choices (mapcar (lambda (entry)
                            (cons (cadr entry) (car entry)))
                          my/themes))
         (label (completing-read "Theme: " choices nil t))
         (theme (cdr (assoc label choices))))
    (when theme
      (my/load-theme theme))))

;; Default theme
(my/load-theme 'doom-one)

;; Keybinding: C-c t to switch theme
(global-set-key (kbd "C-c t") 'my/switch-theme)

;; Global font lock
(global-font-lock-mode t)

(provide 'init-ui)
;;; init-ui.el ends here
