;; Load the publishing system
(require 'ox-publish)

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
