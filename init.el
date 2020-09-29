;; Setup package
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

;; Quickfix for elpa servers not being found
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Don't clutter config with customs
(setq custom-file "~/.emacs.d/custom.el")

;; Get use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; Make sure package files exist in system
(setq use-package-always-ensure t)


;; -- Vim --
;; ;; (E)val
;; (defvar leader-eval-map
;;   (let ((kmp (make-sparse-keymap)))
;;     (define-key kmp "b" 'eval-buffer)
;;     (define-key kmp "e" 'eval-expression)
;;     kmp)
;;   "Leader/Eval shortcuts")

;; ;; (D)escribe
;; (defvar leader-describe-map
;;   (let ((kmp (make-sparse-keymap)))
;;     (define-key kmp "f" 'describe-function)
;;     (define-key kmp "v" 'describe-variable)
;;     kmp)
;;   "Leader/Describe shortcuts")

(defun open-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))

;; Setup leader
(defvar leader-map
  (let ((kmp (make-sparse-keymap)))
    (define-key kmp "h" 'help)
    ;; TODO install dired
    ;; (define-key kmp "y" 'dired-copy-filename-as-kill)
    (define-key kmp "d"
      (let ((kmp (make-sparse-keymap)))
	(define-key kmp "f" 'describe-function)
	(define-key kmp "v" 'describe-variable)
	kmp))
    (define-key kmp "e"
      (let ((kmp (make-sparse-keymap)))
	(define-key kmp "b" 'eval-buffer)
	(define-key kmp "e" 'eval-expression)
	kmp))
    kmp)
  "Keymap for Leader key shortcuts.")

;; For jk -> Esc
(use-package key-chord
  :init
  (key-chord-mode 1))


;; Not working -- fix in the future (isearch doesnt exit)
;; (defun search-visual-selection ()
;;   "Search visual selection"
;;   (interactive)
;;     (let ((search-string (buffer-substring
;;                           (evil-range-beginning (evil-visual-range))
;;                           (evil-range-end (evil-visual-range)))))
;;       ;; Copy into buffer..
;;       (evil-yank
;;        (evil-range-beginning (evil-visual-range))
;;        (evil-range-end (evil-visual-range)))
;;       (evil-search-forward)
;;    ))

(use-package evil
  :after key-chord
  :config
  (setq evil-vsplit-window-right t)
   ;; Make searches case insensitive
  (setq case-fold-search t)
  ;; Leader
  (evil-define-key 'normal 'global (kbd "SPC") leader-map)
  ;; (evil-define-key 'motion 'global "\t1" 'delete-other-windows)
  (key-chord-define evil-insert-state-map  "jk" 'evil-normal-state)
 )

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package highlight-symbol
  :init
  (highlight-symbol-mode))

(use-package counsel
  :hook
  (after-init . ivy-mode))

;; Keeps recently used M-x commands
(use-package amx
  :after ivy)

;; ;; Search text
;; (use-package deadgrep
;;   :if (executable-find "rg"))


;; -- END PACKAGES --

;; putting this in :config does not work for some reason
(evil-mode 1)

;; Line numbers
(linum-mode 1)

(setq-default show-trailing-whitespace t)

(message "Emacs config reloaded")
