;;; package --- Summary

;;; Commentary:

;; -*- mode: emacs-lisp -*-

;;; Code:

;; --------------
;; -- Packages --
;; --------------

;; Load package list
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Install default packages
(defvar my-packages '(better-defaults
                      cl
                      ido
                      paredit
                      idle-highlight-mode
                      ido-ubiquitous
                      find-file-in-project
                      magit
                      smex
                      scpaste
                      org
                      saveplace
                      ffap
                      ansi-color
                      recentf
                      linum
                      smooth-scroll
                      whitespace
                      windresize
                      go-mode
                      web-mode
                      ensime
                      sbt-mode
                      scala-mode
                      js2-mode
                      json-mode
                      react-snippets
                      ;; jsx-mode
                      exec-path-from-shell
                      flycheck
                      flymake
                      ;; flymake-cursor
                      flymake-go
                      yasnippet))

(package-initialize)
(dolist (p my-packages)
  (when (not (package-installed-p p))
        (package-install p)))


;; --------------
;; -- Settings --
;; --------------
(setq show-trailing-whitespace t)
(menu-bar-mode -1)
(setq column-number-mode t)
(setq vc-follow-symlinks t)
(setq inhibit-startup-message t)
(normal-erase-is-backspace-mode 0)
(setq save-abbrevs nil)
(setq suggest-key-bindings t)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(ido-mode t)
(local-set-key "%" 'match-paren)
(setq suggest-key-bindings t)
(setq vc-follow-symlinks t)

;; ---------------
;; -- Functions --
;; ---------------
(defun key (desc)
  (or (and window-system (read-kbd-macro desc))
      (or (cdr (assoc desc real-keyboard-keys))
	  (read-kbd-macro desc))))

(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

(defun next5()
  (interactive)
  (next-line 5))

(defun prev5()
  (interactive)
  (previous-line 5))

(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))

(defun back-window ()
  (interactive)
  (other-window -1))

(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
(fset 'align-colons "\C-[xalign-regex\C-m:\C-m")
(fset 'orgfix "\C-o\C-n\C-c\C-c")
(defalias 'qrr 'query-replace-regexp)

(defun recentf-ido-find-file () 
  "Find a recent file using Ido." 
  (interactive) 
  (let* ((file-assoc-list 
          (mapcar (lambda (x) 
                    (cons (file-name-nondirectory x) 
                          x)) 
                  recentf-list)) 
         (filename-list 
          (remove-duplicates (mapcar #'car file-assoc-list) 
                             :test #'string=)) 
         (filename (ido-completing-read "Choose recent file: " 
                                        filename-list 
                                        nil 
                                        t))) 
    (when filename 
      (find-file (cdr (assoc filename 
                             file-assoc-list))))))

;; -----------------
;; -- Keybindings --
;; -----------------
(defvar real-keyboard-keys
  '(("M-<up>"        . "\M-[1;3A")
    ("M-<down>"      . "\M-[1;3B")
    ("M-<right>"     . "\M-[1;3C")
    ("M-<left>"      . "\M-[1;3D")
    ("C-<return>"    . "\C-j")
    ("C-<delete>"    . "\M-[3;5~")
    ("C-<up>"        . "\M-[1;5A")
    ("C-<down>"      . "\M-[1;5B")
    ("C-<right>"     . "\M-[1;5C")
    ("C-<left>"      . "\M-[1;5D"))
  "An assoc list of pretty key strings
and their terminal equivalents.")

(global-set-key (key "M-<right>")  'windmove-right)
(global-set-key (key "M-<left>")   'windmove-left)
(global-set-key (key "M-<up>")     'windmove-up)
(global-set-key (key "M-<down>")   'windmove-down)
(global-set-key (quote [27 up]) (quote windmove-up))
(global-set-key (quote [27 down]) (quote windmove-down))
(global-set-key (quote [27 left]) (quote windmove-left))
(global-set-key (quote [27 right]) (quote windmove-right))

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\M-R" 'revert-buffer)
(global-set-key "\C-xj" 'gud-tbreak)
(global-set-key "\C-o" 'org-cycle)
(global-set-key "\M-o" 'undo)
(global-set-key "\C-c;" 'comment-or-uncomment-region)
(global-set-key "\C-xi" 'back-window)
(global-set-key "\C-x\C-d" 'edebug-eval-top-level-form)
(global-set-key "\M-n" 'next5)
(global-set-key "\M-p" 'prev5)
(global-set-key "\M-o" 'other-window)
(global-set-key "\M-i" 'back-window)
(global-set-key "\C-z" 'zap-to-char)
(global-set-key "\C-\M-z" 'suspend-emacs)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-d" 'delete-word)
(global-set-key "\M-h" 'backward-delete-word)
(global-set-key "\M-u" 'help-command)
(global-set-key "\M-=" 'align-equals)
(global-set-key "\M-:" 'align-colons)

(global-set-key (kbd "C-x f") 'recentf-ido-find-file)

;; ------------
;; -- Paths --
;; ------------

;; (exec-path-from-shell-copy-env "GOPATH")
;; (exec-path-from-shell-copy-env "GOROOT")

(when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))


;; ------------
;; -- Golang --
;; ------------

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
  (require 'flymake-go)
  (require 'go-autocomplete))

(defun goimports-before-save ()
    (interactive)
    (when (eq major-mode 'go-mode) (goimports)))

(defun goimports ()
  (interactive)
  (let ((tmpfile (make-temp-file "goimports" nil ".go"))
        (patchbuf (get-buffer-create "*Goimports patch*"))
        (errbuf (get-buffer-create "*Goimports Errors*"))
        (coding-system-for-read 'utf-8)
        (coding-system-for-write 'utf-8))

    (with-current-buffer errbuf
      (setq buffer-read-only nil)
      (erase-buffer))
    (with-current-buffer patchbuf
      (erase-buffer))

    (write-region nil nil tmpfile)

    (if (zerop (call-process "goimports" nil errbuf nil "-w" tmpfile))
        (if (zerop (call-process-region (point-min) (point-max) "diff" nil patchbuf nil "-n" "-" tmpfile))
            (progn
              (kill-buffer errbuf)
              (message "Buffer is already goimported"))
          (go--apply-rcs-patch patchbuf)
          (kill-buffer errbuf)
          (message "Applied goimports"))
      (message "Could not apply goimports. Check errors for details")
      (gofmt--process-errors (buffer-file-name) tmpfile errbuf))

    (kill-buffer patchbuf)
    (delete-file tmpfile)))

(defun my-go-mode-hook ()
  "Go mode hooks."
  ;; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)

  ;; Use goimports instead of go-fmt
  ;; (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'goimports-before-save)
  
  ;; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go generate && go build -v && go test -v && go vet"))
  ;; Go oracle
  (load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")
  ;; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)


;; --------------
;; -- Flycheck --
;; --------------

;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)

;; Set relative node_modules for project
(setq flycheck-javascript-eslint-executable "eslint-project-relative")

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(json-jsonlist)))


;; --------
;; -- JS --
;; --------

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))

;; auto-complete
(add-hook 'web-mode-hook 'ac-js2-mode)

;; (require 'js2-mode)
;; (add-to-list 'auto-mode-alist '("\\.js$'" . js2-mode))

;; ;; auto-complete
;; (add-hook 'js2-mode-hook 'ac-js2-mode)

;; ;; use eslint with web-mode for jsx files
;; (flycheck-add-mode 'javascript-eslint 'js2-mode)

;; ;; indentation
;; (setq-default js2-basic-offset 2)
;; (setq js-indent-level 2)
;; (add-hook 'js2-mode-hook (lambda ()
;;                            (progn
;;                              (paredit-mode -1)
;;                              (flycheck-mode))))

;; (eval-after-load 'js2-mode
;;   '(progn
;;      (define-key js2-mode-map (kbd "TAB") (lambda()
;;                                             (interactive)
;;                                             (let ((yas/fallback-behavior 'return-nil))
;;                                               (unless (yas/expand)
;;                                                 (indent-for-tab-command)
;;                                                 (if (looking-back "^\s*")
;;                                                                                                         (back-to-indentation))))))))


;; ---------
;; -- JSX --
;; ---------

;; use web-mode for .jsx files
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; adjust indents for web-mode to 2 spaces
(defun indent-web-mode-hook ()
  "Web mode indentation hook."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2))
(add-hook 'web-mode-hook  'indent-web-mode-hook)

(defun auto-complete-web-mode-hook ()
  "Auto-complete web-mode hook."
  (setq web-mode-ac-sources-alist
        '(("css" . (ac-source-words-in-buffer ac-source-css-property))
          ("html" . (ac-source-words-in-buffer ac-source-abbrev))
          ("jsx" . (ac-source-words-in-buffer ac-source-words-in-same-mode-buffers))
          ("javascript" . (ac-source-words-in-buffer ac-source-words-in-same-mode-buffers))))

  ;; (when (require 'auto-complete nil t)
  ;;   (auto-complete-mode t)))
  (auto-complete-mode 1))
(add-hook 'web-mode-hook  'auto-complete-web-mode-hook)

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  "Better jsx syntax-highlighting in web-mode.
- courtesy of Patrick @halbtuerke"
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

;; (add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
;; (autoload 'jsx-mode "jsx-mode" "JSX mode" t)

;; (custom-set-variables
;;  '(jsx-indent-level 2)
;;  ;; '(jsx-use-flymake t)
;;  '(jsx-syntax-check-mode "compile"))

;; (defun jsx-mode-init ()
;;   (define-key jsx-mode-map (kbd "C-c d") 'jsx-display-popup-err-for-current-line)
;;   (when (require 'auto-complete nil t)
;;     (auto-complete-mode t)))
;; (add-hook 'jsx-mode-hook 'jsx-mode-init)

;; -----------
;; -- Scala --
;; -----------

;; use scala-mode for .scala files
;; (require 'scala-mode)
;; (add-hook 'scala-mode-hook 'scala-mode)

(require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-mode)
;; (ensime-startup-notification nil)

(add-hook 'scala-mode-hook
          (lambda ()
            (show-paren-mode)
            ;; (smartparens-mode)
            (yas-minor-mode)
            (company-mode)
            (ensime-mode)
            (scala-mode:goto-start-of-code)))

;; -----------
;; -- Java --
;; -----------
(require 'ensime)
(add-hook 'java-mode-hook 'ensime-mode)

;; ------------------
;; -- Autocomplete --
;; ------------------

;; YASnippets
(require 'yasnippet)
(yas-global-mode 1)

;; (add-hook 'the-major-mode-hook 'yas-minor-mode-on)
(require 'react-snippets)

;; ;; Remove Yasnippet's default tab key binding
;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)

;; ;; Set Yasnippet's key binding to shift+tab
;; (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)
;; ;; Alternatively use Control-c + tab
;; (define-key yas-minor-mode-map (kbd "\C-c TAB") 'yas-expand)

;; Load the default configuration
(require 'auto-complete-config)

;; ;; Make sure we can find the dictionaries
;; (add-to-list 'ac-dictionary-directories "~/emacs/auto-complete/dict")

;; Use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))

;; set tab key
(ac-config-default)
;; (ac-set-trigger-key "TAB")
;; (ac-set-trigger-key "<tab>")

(global-auto-complete-mode t)

;; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)

;; case sensitivity is important when finding matches
(setq ac-ignore-case nil)

;; Add yasnippet
(add-to-list 'ac-sources 'ac-source-yasnippet)

;; add web-mode
(add-to-list 'ac-modes 'web-mode)

;; -------------
;; -- Flymake --
;; -------------

;; Auto Syntax Error Highlight
;; (when (load "flymake" t)
;;   ;;;; python-specific init-cleanup
;;   (defun flymake-pyflakes-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "pyflakes" (list local-file))))

;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pyflakes-init))

;;   ;;;; css-specific init-cleanup routines
;;   (defun flymake-css-init ()
;;     (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                          'flymake-create-temp-copy))
;;            (local-file  (file-relative-name
;;                          temp-file
;;                          (file-name-directory buffer-file-name))))
;;       (list "csslint" (list "--format=compact" local-file))))

;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.css\\'" flymake-css-init)))

;; (add-hook 'find-file-hook 'flymake-find-file-hook)

(add-hook 'python-mode-hook
          (lambda ()
            (unless (eq buffer-file-name nil) (flymake-mode 1)) ;dont invoke flymake on temporary buffers for the interpreter
            (local-set-key [f2] 'flymake-goto-prev-error)
            (local-set-key [f3] 'flymake-goto-next-error)
            ))

;; Set flymake color scheme
'(flymake-errline ((((class color)) (:background "violet" :foreground "black"))))
'(flymake-warnline ((((class color)) (:background "LightBlue2" :foreground "black"))))


;; -----------
;; -- Modes --
;; -----------

(add-hook 'outline-minor-mode-hook
          (lambda ()
            (define-key outline-minor-mode-map [(control tab)] 'org-cycle)
            (define-key outline-minor-mode-map [(backtab)]
            'org-global-cycle))) ;; (shift tab) doesn't work

(require 'org)
(defun set-up-outline-minor-mode (outline-regexp)
  "Define outline minor modes."
  (set (make-local-variable 'outline-regexp) outline-regexp)
  (outline-minor-mode t)
  (org-overview)
  (org-content))

(add-hook 'python-mode-hook
          (lambda () (set-up-outline-minor-mode "[ \t]*\\(def .+\\|class
          .+\\|##\\)")))
 
(add-hook 'coffee-mode-hook
          (lambda () (set-up-outline-minor-mode "[ \t]*\\(class
          .+\\)")))
 
(add-hook 'js-mode-hook
          (lambda () (set-up-outline-minor-mode ".+\\(function .+\\)")))
 
(add-hook 'markdown-mode-hook
          (lambda () (set-up-outline-minor-mode "##")))
 
(add-hook 'emacs-lisp-mode-hook
          (lambda () (set-up-outline-minor-mode "\\((\\|;;;\\)")))
 
(add-hook 'ess-mode-hook
          (lambda ()
            (unless (eq noweb-code-mode 'R-mode)
              (set-up-outline-minor-mode "[a-zA-Z._][a-zA-Z._0-9]* *<-
          *function"))))
 
(add-hook 'bibtex-mode-hook
          (lambda () (set-up-outline-minor-mode "@")))

(add-hook 'go-mode-hook
          (lambda () (set-up-outline-minor-mode "[ \t]*\\(pack\\|.*func\\|impo\\|cons\\|var.\\|type\\)")))

(add-hook 'java-mode-hook
          (lambda () (set-up-outline-minor-mode "\\(?:\\([ \t]*.*\\(class\\|interface\\)[ \t]+[a-zA-Z0-9_]+[ \t\n]*\\({\\|extends\\|implements\\)\\)\\|[ \t]*\\(public\\|private\\|static\\|final\\|native\\|synchronized\\|transient\\|volatile\\|strictfp\\| \\|\t\\)*[ \t]+\\(\\([a-zA-Z0-9_]\\|\\( *\t*< *\t*\\)\\|\\( *\t*> *\t*\\)\\|\\( *\t*, *\t*\\)\\|\\( *\t*\\[ *\t*\\)\\|\\(]\\)\\)+\\)[ \t]+[a-zA-Z0-9_]+[ \t]*(\\(.*\\))[ \t]*\\(throws[ \t]+\\([a-zA-Z0-9_, \t\n]*\\)\\)?[ \t\n]*{\\)" )))

(add-hook 'scala-mode-hook
          (lambda () (set-up-outline-minor-mode "[ \t]*\\(.*class\\|trait\\|object\\|.*{$\\)" )))

;; (add-hook 'scala-mode-hook
;;           (lambda () (set-up-outline-minor-mode "[ \t]*# \|[ \t]+\(class\|trait\|object\|def\|if\|elif\|else\|while\|until\|for\|foreach\|try\|except\|with\) ")))

;; (add-hook 'scala-mode-hook
;;           (lambda () (set-up-outline-minor-mode "\\(?:\\([ \t]*.*\\(class\\|trait\\|interface\\)[ \t]+[a-zA-Z0-9_]+[ \t\n]*\\({\\|extends\\|implements\\)\\)\\|[ \t]*\\(def\\|public\\|private\\|protected\\|static\\|final\\|native\\|synchronized\\|transient\\|volatile\\|strictfp\\| \\|\t\\)*[ \t]+\\(\\([a-zA-Z0-9_]\\|\\( *\t*< *\t*\\)\\|\\( *\t*> *\t*\\)\\|\\( *\t*, *\t*\\)\\|\\( *\t*\\[ *\t*\\)\\|\\(]\\)\\)+\\)[ \t]+[a-zA-Z0-9_]+[ \t]*(\\(.*\\))[ \t]*\\(throws[ \t]+\\([a-zA-Z0-9_, \t\n]*\\)\\)?[ \t\n]*{\\)" )))

;; ----------
;; -- Misc --
;; ----------

;; Load Emacs Desktop
(load "desktop")
(desktop-load-default)
(desktop-read)

;; Column number mode
(setq column-number-mode t)

;; Recent file mode
(recentf-mode 1)

;; Auto fill mode
(auto-fill-mode nil)

;; No new line at end of file
(setq require-final-newline t)

(provide 'init)
;;; init.el ends here
