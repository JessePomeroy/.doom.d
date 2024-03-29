;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Jesse Pomeroy"
      user-mail-address "thinkingofview@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;; never lose your mouse
(beacon-mode 1)

;; bookmarks
(setq bookmark-default-file "~/.doom.d/bookmarks")

(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks"                          "L" #'list-bookmarks
       :desc "Set bookmark"                            "m" #'bookmark-set
       :desc "Delete bookmark"                         "M" #'bookmark-set
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

;; emojis in emacs xD
(use-package emojify
  :hook (after-init . global-emojify-mode))

;; line control/comments
(setq display-line-numbers-type t)
(map! :leader
      :desc "Comment or uncomment lines"      "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
       :desc "Toggle line numbers"            "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines"          "t" #'toggle-truncate-lines))

;; markdown
(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.7))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.2)))))

;; minimap
(setq minimap-window-location 'right)
(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Toggle minimap-mode" "m" #'minimap-mode))

;; modeline settings
;;(set-face-attribute 'mode-line nil :font "Ubuntu Mono-13")
(setq doom-modeline-height 30     ;; sets modeline height
      doom-modeline-bar-width 5   ;; sets right bar width
      doom-modeline-persp-name t  ;; adds perspective name to modeline
      doom-modeline-persp-icon t) ;; adds folder icon next to persp name

;; neotree
(after! neotree
  (setq neo-smart-open t
        neo-window-fixed-size nil))
(after! doom-themes
  (setq doom-neotree-enable-variable-pitch t))
(map! :leader
      :desc "Toggle neotree file viewer" "t n" #'neotree-toggle
      :desc "Open directory in neotree"  "d n" #'neotree-dir)

;; org mode stuff
(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)
(after! org
  (setq org-directory "~/Documents/Org/"
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-hide-emphasis-markers t
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
        '(("google" . "http://www.google.com/search?q=")
          ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
          ("ddg" . "https://duckduckgo.com/?q=")
          ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-table-convert-region-max-lines 20000
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
        '((sequence
           "TODO(t)"           ; A task that is ready to be tackled
           "BLOG(b)"           ; Blog writing assignments
           "GYM(g)"            ; Things to accomplish at the gym
           "PROJ(p)"           ; A project that contains other tasks
           "VIDEO(v)"          ; Video assignments
           "WAIT(w)"           ; Something is holding up this task
           "|"                 ; The pipe necessary to separate "active" states and "inactive" states
           "DONE(d)"           ; Task has been completed
           "CANCELLED(c)" )))) ; Task has been cancelled

;; org-agenda
(after! org
  (setq org-agenda-files '("D:\notes/Org/agenda.org")))

(setq
 ;; org-fancy-priorities-list '("[A]" "[B]" "[C]")
 ;; org-fancy-priorities-list '("❗" "[B]" "[C]")
 org-fancy-priorities-list '("🟥" "🟧" "🟨")
 org-priority-faces
 '((?A :foreground "#ff6c6b" :weight bold)
   (?B :foreground "#98be65" :weight bold)
   (?C :foreground "#c678dd" :weight bold))
 org-agenda-block-separator 8411)

(setq org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (tags "PRIORITY=\"B\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
          (tags "PRIORITY=\"C\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Low-priority unfinished tasks:")))
          (tags "customtag"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Tasks marked with customtag:")))

          (agenda "")
          (alltodo "")))))

;; orga-auto-tangle
(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(defun dt/insert-auto-tangle-tag ()
  "Insert auto-tangle tag in a literate config."
  (interactive)
  (evil-org-open-below 1)
  (insert "#+auto_tangle: t ")
  (evil-force-normal-state))

(map! :leader
      :desc "Insert auto_tangle tag" "i a" #'dt/insert-auto-tangle-tag)

;; org fonts
;;(defun dt/org-colors-doom-one ()
;;  "Enable Doom One colors for Org headers."
;;  (interactive)
;;  (dolist
;;      (face
;;       '((org-level-1 1.7 "#51afef" ultra-bold)
;;        (org-level-2 1.6 "#c678dd" extra-bold)
;;         (org-level-3 1.5 "#98be65" bold)
;;         (org-level-4 1.4 "#da8548" semi-bold)
;;         (org-level-5 1.3 "#5699af" normal)
;;         (org-level-6 1.2 "#a9a1e1" normal)
;;         (org-level-7 1.1 "#46d9ff" normal)
;;         (org-level-8 1.0 "#ff6c6b" normal)))
;;    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
;;    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))
;;
;;(defun dt/org-colors-dracula ()
;;  "Enable Dracula colors for Org headers."
;;  (interactive)
;;  (dolist
;;      (face
;;       '((org-level-1 1.7 "#8be9fd" ultra-bold)
;;         (org-level-2 1.6 "#bd93f9" extra-bold)
;;         (org-level-3 1.5 "#50fa7b" bold)
;;         (org-level-4 1.4 "#ff79c6" semi-bold)
;;         (org-level-5 1.3 "#9aedfe" normal)
;;         (org-level-6 1.2 "#caa9fa" normal)
;;         (org-level-7 1.1 "#5af78e" normal)
;;         (org-level-8 1.0 "#ff92d0" normal)))
;;    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
;;    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))
;;
;;(defun dt/org-colors-gruvbox-dark ()
;;  "Enable Gruvbox Dark colors for Org headers."
;;  (interactive)
;;  (dolist
;;      (face
;;       '((org-level-1 1.7 "#458588" ultra-bold)
;;         (org-level-2 1.6 "#b16286" extra-bold)
;;         (org-level-3 1.5 "#98971a" bold)
;;         (org-level-4 1.4 "#fb4934" semi-bold)
;;         (org-level-5 1.3 "#83a598" normal)
;;         (org-level-6 1.2 "#d3869b" normal)
;;         (org-level-7 1.1 "#d79921" normal)
;;         (org-level-8 1.0 "#8ec07c" normal)))
;;    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
;;    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))
;;
;;(defun dt/org-colors-monokai-pro ()
;;  "Enable Monokai Pro colors for Org headers."
;;  (interactive)
;;  (dolist
;;      (face
;;       '((org-level-1 1.7 "#78dce8" ultra-bold)
;;         (org-level-2 1.6 "#ab9df2" extra-bold)
;;         (org-level-3 1.5 "#a9dc76" bold)
;;         (org-level-4 1.4 "#fc9867" semi-bold)
;;         (org-level-5 1.3 "#ff6188" normal)
;;         (org-level-6 1.2 "#ffd866" normal)
;;         (org-level-7 1.1 "#78dce8" normal)
;;         (org-level-8 1.0 "#ab9df2" normal)))
;;    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
;;    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))
;;
(defun dt/org-colors-nord ()
  "Enable Nord colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#81a1c1" ultra-bold)
         (org-level-2 1.6 "#b48ead" extra-bold)
         (org-level-3 1.5 "#a3be8c" bold)
         (org-level-4 1.4 "#ebcb8b" semi-bold)
         (org-level-5 1.3 "#bf616a" normal)
         (org-level-6 1.2 "#88c0d0" normal)
         (org-level-7 1.1 "#81a1c1" normal)
         (org-level-8 1.0 "#b48ead" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
  (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

;; (defun dt/org-colors-oceanic-next ()
;; "Enable Oceanic Next colors for Org headers."
;; (interactive)
;; (dolist
;; (face
;; '((org-level-1 1.7 "#6699cc" ultra-bold)
;; (org-level-2 1.6 "#c594c5" extra-bold)
;; (org-level-3 1.5 "#99c794" bold)
;; (org-level-4 1.4 "#fac863" semi-bold)
;; (org-level-5 1.3 "#5fb3b3" normal)
;; (org-level-6 1.2 "#ec5f67" normal)
;; (org-level-7 1.1 "#6699cc" normal)
;; (org-level-8 1.0 "#c594c5" normal)))
;; (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
;; (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))
;;
;; (defun dt/org-colors-palenight ()
;; "Enable Palenight colors for Org headers."
;; (interactive)
;; (dolist
;; (face
;; '((org-level-1 1.7 "#82aaff" ultra-bold)
;; (org-level-2 1.6 "#c792ea" extra-bold)
;; (org-level-3 1.5 "#c3e88d" bold)
;; (org-level-4 1.4 "#ffcb6b" semi-bold)
;; (org-level-5 1.3 "#a3f7ff" normal)
;; (org-level-6 1.2 "#e1acff" normal)
;; (org-level-7 1.1 "#f07178" normal)
;; (org-level-8 1.0 "#ddffa7" normal)))
;; (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
;; (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))
;;
;; (defun dt/org-colors-solarized-dark ()
;; "Enable Solarized Dark colors for Org headers."
;; (interactive)
;; (dolist
;; (face
;; '((org-level-1 1.7 "#268bd2" ultra-bold)
;; (org-level-2 1.6 "#d33682" extra-bold)
;; (org-level-3 1.5 "#859900" bold)
;; (org-level-4 1.4 "#b58900" semi-bold)
;; (org-level-5 1.3 "#cb4b16" normal)
;; (org-level-6 1.2 "#6c71c4" normal)
;; (org-level-7 1.1 "#2aa198" normal)
;; (org-level-8 1.0 "#657b83" normal)))
;; (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
;; (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))
;;
;; (defun dt/org-colors-solarized-light ()
;; "Enable Solarized Light colors for Org headers."
;; (interactive)
;; (dolist
;; (face
;; '((org-level-1 1.7 "#268bd2" ultra-bold)
;; (org-level-2 1.6 "#d33682" extra-bold)
;; (org-level-3 1.5 "#859900" bold)
;; (org-level-4 1.4 "#b58900" semi-bold)
;; (org-level-5 1.3 "#cb4b16" normal)
;; (org-level-6 1.2 "#6c71c4" normal)
;; (org-level-7 1.1 "#2aa198" normal)
;; (org-level-8 1.0 "#657b83" normal)))
;; (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
;; (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))
;;
;; (defun dt/org-colors-tomorrow-night ()
;; "Enable Tomorrow Night colors for Org headers."
;; (interactive)
;; (dolist
;; (face
;; '((org-level-1 1.7 "#81a2be" ultra-bold)
;; (org-level-2 1.6 "#b294bb" extra-bold)
;; (org-level-3 1.5 "#b5bd68" bold)
;; (org-level-4 1.4 "#e6c547" semi-bold)
;; (org-level-5 1.3 "#cc6666" normal)
;; (org-level-6 1.2 "#70c0ba" normal)
;; (org-level-7 1.1 "#b77ee0" normal)
;; (org-level-8 1.0 "#9ec400" normal)))
;; (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
;; (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))
;;
;; Load our desired dt/org-colors-* theme on startup
;; (dt/org-colors-doom-one)

;; org-journal
(setq org-journal-dir "D:\notes/Org/journal/"
      org-journal-date-prefix "* "
      org-journal-time-prefix "** "
      org-journal-date-format "%B %d, %Y (%A) "
      org-journal-file-format "%Y-%m-%d.org")

;; org-roam
(after! org
  (setq org-roam-directory "D:\notes/OrgRoamNotes/"
        org-roam-graph-viewer "/usr/bin/brave"))

(map! :leader
      (:prefix ("n r" . "org-roam")
       :desc "Completion at point" "c" #'completion-at-point
       :desc "Find node"           "f" #'org-roam-node-find
       :desc "Show graph"          "g" #'org-roam-graph
       :desc "Insert node"         "i" #'org-roam-node-insert
       :desc "Capture to node"     "n" #'org-roam-capture
       :desc "Toggle roam buffer"  "r" #'org-roam-buffer-toggle))

;; rainbow mode
(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                     (list 'org-agenda-mode)))
      (rainbow-mode 1))))
(global-rainbow-mode 1 )

;; ctrlf
(use-package! ctrlf
  :hook
  (after-init . ctrlf-mode))
