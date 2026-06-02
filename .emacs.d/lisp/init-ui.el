;;; init-ui.el --- UI, theme, fonts, appearance

;;; Commentary:
;; Visual settings: theme, fonts, mode line, cursor, window title

;;; Code:

;; CUA Mode (Windows-style editing keys)
(cua-mode t)

;; Mode line: clean and minimal
(setq-default mode-line-format
              '("%e"
                mode-line-modified
                " "
                mode-line-buffer-identification
                "  "
                mode-line-position
                "  ("
                mode-name
                ")  "
                mode-line-end-spaces))

;; Buffer List: use regular window
(add-to-list 'display-buffer-alist
             '("\\*Buffer List\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)
               (window-width . 0.5)))

;; UI elements
(menu-bar-mode -1)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode 1))
(column-number-mode t)
(global-display-line-numbers-mode t)
(temp-buffer-resize-mode 1)

;; Editing helpers
(show-paren-mode 1)
(electric-pair-mode t)
(global-auto-revert-mode t)

;; Cursor
(set-cursor-color "#00ff00")
(blink-cursor-mode 0)

;; Font
(when (display-graphic-p)
  (condition-case nil
      (set-face-attribute 'default nil :font "JetBrains Mono-16")
    (error (message "Failed to set JetBrains Mono font, using default."))))

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
  (let* ((choices (mapcar (lambda (t) (cons (cadr t) (car t))) my/themes))
         (label (completing-read "Theme: " choices nil t))
         (theme (cdr (assoc label choices))))
    (when theme
      (my/load-theme theme))))

;; Default theme
(my/load-theme 'doom-tokyo-night)

;; Keybinding: C-c t to switch theme
(global-set-key (kbd "C-c t") 'my/switch-theme)

;; Global font lock
(global-font-lock-mode t)

(provide 'init-ui)
;;; init-ui.el ends here
