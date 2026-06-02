;;; init-lang.el --- Language modes configuration

;;; Commentary:
;; C/C++, CMake, Protobuf, Verilog, Specman, Tcl, Dcsh, etc.

;;; Code:

;; CMake
(autoload 'cmake-mode "cmake-mode" "CMake mode" t)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))

;; Protobuf
(autoload 'protobuf-mode "protobuf-mode" "protobuf mode" t)
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))

;; Verilog
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t)
(add-to-list 'auto-mode-alist '("\\.v\\'" . verilog-mode))
(add-to-list 'auto-mode-alist '("\\.s?vh?\\'" . verilog-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . verilog-mode))
(setq verilog-auto-newline nil
      verilog-tab-always-indent nil)

;; Template system
(require 'template)
(template-initialize)
(setq template-default-directories
      (cons (concat my/site-lisp-dir "template/") template-default-directories))

;; Synopsys keyword support for tcl-mode
(load (concat my/site-lisp-dir "syn-keyword.el") t nil t)

;; Dcsh (Synopsys DC Shell)
(autoload 'dcsh-mode "dcsh-mode" "Dcsh Mode" t)
(add-to-list 'auto-mode-alist '("\\.scr\\'" . dcsh-mode))

;; Specman
(autoload 'specman-mode "specman-mode" "Specman code editing mode" t)
(add-to-list 'auto-mode-alist '("\\.e\\'" . specman-mode))
(add-to-list 'auto-mode-alist '("\\.e3\\'" . specman-mode))
(add-to-list 'auto-mode-alist '("\\.load\\'" . specman-mode))
(add-to-list 'auto-mode-alist '("\\.ecom\\'" . specman-mode))
(add-to-list 'auto-mode-alist '("\\.etst\\'" . specman-mode))

;; Shell script
(add-to-list 'auto-mode-alist '("bashrc" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.bashrc" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.cfg" . shell-script-mode))

;; Tcl
(when (< max-specpdl-size 1000)
  (setq max-specpdl-size 2000))
(add-to-list 'auto-mode-alist '(".*\\.pt$" . tcl-mode))
(add-to-list 'auto-mode-alist '(".*\\.synopsys_..\\.setup$" . tcl-mode))

;; C files
(add-to-list 'auto-mode-alist '("vfl_.+" . c-mode))
(add-to-list 'auto-mode-alist '("vflist$" . c-mode))
(add-to-list 'auto-mode-alist '(".*\\.ld$" . c-mode))

;; CUDA
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c-mode))

(provide 'init-lang)
;;; init-lang.el ends here
