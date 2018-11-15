#|
  This file is a part of holy-water project.
|#

(defsystem "holy-water"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ("mito")
  :components ((:module "src"
                :components
                ((:file "package")
                 (:module "dao"
                  :components ((:file "rs_angel")
                               (:file "rs_maledict-type")
                               (:file "rs_maledict")
                               (:file "rs_impure")
                               (:file "th_angel-maledict")
                               (:file "ev_collect-impure")
                               (:file "ev_purge")))
                 (:file "creator")
                 (:file "angel-maledict")
                 (:file "collect-impure")
                 (:file "angel")
                 (:file "maledict")
                 (:file "impure"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "holy-water-test"))))
