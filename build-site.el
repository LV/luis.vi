;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa"  . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil             ;; Don't show validation link
      org-html-head-include-scripts nil        ;; Use our own scripts
      org-html-head-include-default-style nil  ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "luis.vi"
	     :recursive t
	     :base-directory "./content"
	     :publishing-directory "./public"
	     :publishing-function 'org-html-publish-to-html
	     :author "Luis Victoria"
	     :email "v@lambda.lv"
	     :with-author nil      ;; Don't include author name
	     :with-creator nil     ;; Don't include Emacs and Org versions in footer
	     :with-toc nil         ;; Don't include a table of contents
	     :section-numbers nil  ;; Don't include section numbers
	     :time-stamp-file nil  ;; Don't include time stamp in file
	     )))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
