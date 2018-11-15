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
                               (:file "maledict")
                               (:file "impure")))
                 (:file "package")
                 (:file "render")
                 (:file "route"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "holy-water.api-test"))))
