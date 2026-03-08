;;                                                  __ _
;;   ___ _ __ ___   __ _  ___ ___   ___ ___  _ __  / _(_) __ _
;;  / _ \ '_ ` _ \ / _` |/ __/ __| / __/ _ \| '_ \| |_| |/ _` |
;; |  __/ | | | | | (_| | (__\__ \| (_| (_) | | | |  _| | (_| |
;;  \___|_| |_| |_|\__,_|\___|___(_)___\___/|_| |_|_| |_|\__, |
;;                                                       |___/

(require 'package)

;; Lista de repositorios
(setq package-archives
      '(("elpa" . "https://elpa.gnu.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

;; Inicializa packages
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Instala use-package no está instalado (viene en Emacs 29+)
(unless (package-installed-p 'use-package) 
  (package-install 'use-package))
;; Carga use-package
(require 'use-package)

;; Instale un paquete automáticamente si no lo está
(setq use-package-always-ensure t)
(eval-when-compile (require 'use-package))

;; Ventana de inicio y mensaje
(setq inhibit-startup-screen t)
(setq initial-scratch-message ";;   Saluton!\n")

;; IU
(menu-bar-mode -1)               ; Barra de menú
(tool-bar-mode -1)               ; Barra de herramientas
(tooltip-mode -1)                ; Información sobre herramientas
(set-fringe-mode 10)             ; Margen
(scroll-bar-mode -1)             ; Barra de scroll
(setq visible-bell t)            ; Campana visible
(setq-default cursor-type 'box)  ; Tipo de cursor
(blink-cursor-mode t)            ; Parpadeo del cursor

(global-display-line-numbers-mode t)        ; Enumera líneas
(setq display-line-numbers-type 'relative)  ; Enumeración líneas relativo

;; Deshabilitado para estos modos
(dolist (mode '(org-mode-hook
                vterm-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq-default indent-tabs-mode nil)  ; Usa espacios no tabulaciones
(setq-default tab-width 2)           ; 2 espacios de ancho

(delete-selection-mode t)  ; Eliminar texto seleccionado

(electric-pair-mode 1)  ; Auto-cierra signos {[()]}.

;; Evita que se corten las palabras al pasar el límited
(global-visual-line-mode t)

;; Destaca linea actual
(global-hl-line-mode 1)

;; Scroll liso
(setq scroll-margin 8
      scroll-step 1
      scroll-conservatively 10000)

(outline-minor-mode t)
(setq-default fill-column 80)  ; Ancho de línea
(setq use-dialog-box 1)        ; Cuadros de diálogo de la IU cuando se le solicite
(completion-preview-mode t)
(auto-fill-mode t)
(editorconfig-mode t)

;; Carga en el buffer los cambios externos
(global-auto-revert-mode t)

;; Revierte dired y otros buffers
(setq global-auto-revert-non-file-buffers t)

;; Modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 28))

;; Número de columna
(column-number-mode t)

(setq use-short-answers t)  ; Responder y/n en lugar de yes/no
(use-package savehist
  :init (savehist-mode))   ; Recuerda el historial del minibuffer

;; Historial
(recentf-mode t)         ; Recuerda archivos abiertos recientemente
(save-place-mode t)      ; Recuerda última posición del cursor en los archivos
(setq history-length 25) ; Asigna cuántos comandos muestra el historial
(desktop-save-mode 1)    ; Guarda escritorio

;; Idioma del diccionario. Revisa palabra actual -> M-$
(setq ispell-local-dictionary "castellano")

;; Directorio de respaldos
(setq backup-directory-alist '(("." . "~/.config/emacs/backup")))

;; Mueve la configuración de variables a un archivo separado
(setq custom-file "/home/fenix/.config/emacs/custom-vars.el")
(load custom-file 'noerror 'nomessage)

;; Tema
   (use-package modus-themes
    :init
    (setq modus-themes-italic-constructs t
          modus-themes-bold-constructs t
          modus-themes-mixed-fonts t
          modus-themes-org-blocks 'gray-background)
    :config
    (load-theme 'modus-vivendi :no-confirm))

  (setq-default line-spacing 0.12)

;; Font
  (set-face-attribute 'default nil
                      :font "JetBrains Mono 14" 
                      :height 140
                      :weight 'medium)
  (set-face-attribute 'variable-pitch nil
                      :font "Font Awesome 6"
                      :height 110
                      :weight 'regular)
  ;;(set-face-attribute 'font-lock-comment-face nil
  ;;    :slant 'italic)
  ;;(set-face-attribute 'font-lock-keyword-face nil
  ;;    :slant 'italic)
  ;;(add-to-list 'default-frame-alist '(font . "JetBrains Mono-12"))

;; Icons
  (use-package nerd-icons)

;; Navegar entre ventanas S-<flechas>
  (global-set-key [C-left] 'windmove-left)          ; mover a ventana izquierda
  (global-set-key [C-right] 'windmove-right)        ; mover a ventana derecha
  (global-set-key [C-up] 'windmove-up)              ; mover a ventana arriba
  (global-set-key [C-down] 'windmove-down)          ; mover a ventana abajo

;; Navegar en archivos al estilo vim.
(use-package evil
  :init
  :config
  (setq evil-emacs-state-cursor '("#649bce" box))
  (setq evil-normal-state-cursor '("#ebcb8b" box))
  (setq evil-operator-state-cursor '("#ebcb8b" hollow))
  (setq evil-visual-state-cursor '("#677691" box))
  (setq evil-insert-state-cursor '("#eb998b" (bar . 2)))
  (setq evil-replace-state-cursor '("#eb998b" hbar))
  (setq evil-motion-state-cursor '("#ad8beb" box))
  (evil-mode 1))

;; Pulsa una telca de prefijo, espera y te muestra continuaciones disponibles
  (use-package which-key
    :config
    (which-key-mode)
    (which-key-setup-minibuffer)
    (setq which-key-idle-delay 0.3))

;; Colorea los códigos de colores en archivos
  (use-package rainbow-mode
    :hook org-mode prog-mode)

;; Muestra comandos de teclado que escribe el usuario
  (use-package command-log-mode)

;; Autocompletado vertical.
  (use-package vertico
    :custom
    (vertico-count 10)
    (vertico-resize t)
    :config
    (vertico-mode))

;; Permite búsqueda difusa
  (use-package orderless
    :custom
    (completion-styles '(orderless basic)))

;; Asigna atajos de teclado para consultas de buffer, búsquedas entre otros
  (use-package consult
    :bind (
  	 ("M-s b" . consult-buffer)
  	 ("M-s g" . consult-grep)
  	 ("M-s j" . consult-outline)))

;; Intérprete de archivos .adoc.
  (use-package adoc-mode
    :mode "*.adoc")

;; org-mode: indica que un encabezado está colapsado
  (setq org-ellipsis  " ⤵")

;; Identa los encabezados según nivel
  (add-hook 'org-mode-hook #'org-indent-mode)

;; Centra texto para mejor lectura
  (use-package visual-fill-column
    :hook (org-mode . (lambda ()
                        (setq visual-fill-column-width 100
                              visual-fill-column-center-text t)
                        (visual-fill-column-mode 1))))

  ;; Colores encabezados
  ;; Azules/Cian: SkyBlue1, LightSkyBlue, DeepSkyBlue, Cyan, CadetBlue.
  ;; Verdes: PaleGreen, LightGreen, LimeGreen, SeaGreen.
  ;; Rojos/Rosa: IndianRed, LightCoral, HotPink, Salmon.
  ;; Amarillos/Naranjas: Gold, Yellow, LightGoldenrod, Orange.
  ;; Blancos/Grises: White, Gray, LightGray, Snow. 
  (custom-set-faces
   '(org-level-1 ((t (:foreground "SkyBlue1" :weight bold))))
   '(org-level-2 ((t (:foreground "LightGreen" :weight bold))))
   '(org-level-3 ((t (:foreground "LightGoldenrod" :weight bold)))))

;; Coloca viñetas en archivos org
  (use-package org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Para presentaciones.
  (use-package org-present
    :commands org-present
    :config
    (defun my/org-present-prepare-slide (buffer-name heading)
      ;; Show only top-level headlines
      (org-overview)

      ;; Unfold the current entry
      (org-show-entry)

      ;; Show only direct subheadings of the slide but don't expand them
      (org-show-children))

    (defun my/org-present-start ()
      ;; Tweak font sizes
      (setq-local face-remapping-alist '((default (:height 2.5) variable-pitch)
                                         (header-line (:height 4.0) variable-pitch)
                                         (org-document-title (:height 2.75) org-document-title)
                                         (org-code (:height 2.55) org-code)
                                         (org-table (:height 2.55) org-table)
                                         (org-formula (:height 2.55 :foreground "#ffffff") org-formula)
                                         (org-verbatim (:height 2.55) org-verbatim)
                                         (org-block (:height 2.25) org-block)
                                         (org-block-begin-line (:height 2.7) org-block)))

      ;; Set a blank header line string to create blank space at the top
      (setq header-line-format " ")

      ;; Display inline images automatically
      (org-display-inline-images)

      ;; Center the presentation and wrap lines
      (visual-fill-column-mode 1)
      (visual-line-mode 1))

    (defun my/org-present-end ()
      ;; Reset font customizations
      (setq-local face-remapping-alist '((default variable-pitch default)))

      ;; Clear the header line string so that it isn't displayed
      (setq header-line-format nil)

      ;; Stop displaying inline images
      (org-remove-inline-images)

      ;; Stop centering the document
      (visual-fill-column-mode 0)
      (visual-line-mode 0))

    (add-hook 'org-present-mode-hook 'my/org-present-start)
    (add-hook 'org-present-mode-quit-hook 'my/org-present-end)
    (add-hook 'org-present-after-navigate-functions 'my/org-present-prepare-slide))

;; Inserta una tabla de contenido en un lugar específico de tu documento org.
  (use-package toc-org)
  
  (if (require 'toc-org nil t)
        (add-hook 'org-mode-hook 'toc-org-mode)
        (warn "toc-org not found"))

;; Muestra los documentos de lenguaje C al estilo linux.
  (setq c-default-style "linux"
    c-basic-ofset 4)
