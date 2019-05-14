#|
  This file is a part of holy-water.api project.
|#

(defsystem "holy-water.api"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ("caveman2" "lack-middleware-validation")
  :components ((:module "src"
                :components
                ((:module "controller"
                  :components ((:file "package")
                               (:file "orthodox")
                               (:file "angel")
                               (:file "utilities")
                               (:file "purge")
                               (:file "maledict")
                               (:file "deamon")
                               (:file "impure")
                               (:file "deccots")
                               (:file "request-message")
                               (:file "pages")))
                 (:file "package")
                 (:file "render")
                 (:file "utililties")
                 (:file "route"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "holy-water.api-test"))))
