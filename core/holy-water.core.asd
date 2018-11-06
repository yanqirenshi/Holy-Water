#|
  This file is a part of holy-water.core project.
|#

(defsystem "holy-water.core"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "holy-water.core"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "holy-water.core-test"))))
