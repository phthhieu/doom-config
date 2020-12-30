;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Hieu Pham"
      user-mail-address "phthhieu@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;; I wanna have bigger font
(setq doom-font (font-spec :family "Hack" :size 24))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/notes")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type "relative")

;; Local leader key
(setq doom-localleader-key ",")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))

;; To go to previous buffer pretty easy
(global-set-key (kbd "C-<backspace>") 'switch-to-last-buffer)

;; I don't really want to see line numbers
(setq display-line-numbers-type nil)

;; Custom bindings
;; Easy motion with a single s
(setq avy-all-windows t)
(map! :nv "s" #'evil-avy-goto-char-timer)

;; Auto format buffer when saving
(add-hook! js-mode prettier-js-mode)
(add-hook! web-mode prettier-js-mode)
(add-hook! typescript-mode prettier-js-mode) ;; remember to install ts-ls by using lsp-install-server

;; Load custom config for EH projects
(load! "eh/prodigy")
;; General config
(load! "org-mode")

;; Open in fullscreen
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Use bundle exec to run rubocop
(after! ruby-mode
  (setq-hook! 'ruby-mode-hook
    flycheck-command-wrapper-function (lambda (command)
                                        (append '("bundle" "exec") command))))

;; Make eslint work with flycheck on js2/ts mode

(defun js-config ()
  (flycheck-disable-checker 'lsp-ui)
  (flycheck-select-checker 'javacript-eslint)
  )

(add-hook 'js2-mode-hook #'js-config)

;; To make typescript work in Emacs
;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
;; (add-hook 'typescript-mode-hook #'js-config)
