#|
  This file is a part of holy-water.api project.
|#

(defsystem "holy-water.api"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "holy-water.api"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "holy-water.api-test"))))
