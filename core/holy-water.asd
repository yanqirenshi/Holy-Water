#|
  This file is a part of holy-water project.
|#

(defsystem "holy-water"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ("mito" "api.gitlab")
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "database")
                 (:module "dao"
                  :components ((:file "rs_angel")
                               (:file "rs_grigori")
                               (:file "rs_orthodox")
                               (:file "rs_orthodox-duty")
                               (:file "rs_maledict-type")
                               (:file "rs_maledict")
                               (:file "rs_deamon")
                               (:file "rs_impure")
                               (:file "rs_ghost-shadow")
                               (:file "rs_deccot")
                               (:file "th_deamon-impure")
                               (:file "th_angel-maledict")
                               (:file "th_ghost-shadow_angel")
                               (:file "th_ghost-shadow_deccot")
                               (:file "th_orthodox_angel")
                               (:file "ev_setting-auth")
                               (:file "ev_collect-impure")
                               (:file "ev_purge")
                               (:file "ev_request")
                               (:file "ev_incantation")
                               (:file "re_impure")))
                 (:file "dependency")
                 (:file "auth")
                 (:file "creator")
                 (:file "angel-maledict")
                 (:file "collect-impure")
                 (:file "orthodox")
                 (:file "orthodox-duty")
                 (:file "angel")
                 (:file "maledict")
                 (:file "impure")
                 (:file "purge")
                 (:file "request")
                 (:file "deamon")
                 (:file "deccot")
                 (:file "ghost-shadow")
                 (:file "incantation")
                 (:module "actions"
                  :components ((:file "stop-impure")
                               (:file "start-impure")
                               (:file "move-impure")
                               (:file "finish-impure")
                               (:file "save-impure")))
                 (:module "fetch-list"
                  :components ((:file "util")
                               (:file "list-cemeteries")
                               (:file "list-maledict-impures")
                               (:file "list-orthodox-angels")
                               (:file "list-purge-by-angel-sql-template")
                               (:file "list-purge-by-impure")
                               (:file "list-request-messages-unred")
                               (:file "list-requested-uncomplete-impures")
                               (:file "list-summary-purge-by-deamon")
                               (:file "list-summary-purge-by-impure")
                               (:file "list-summay-impure-cemeteries-by-date-damon")
                               (:file "list-summay-purge-time-by-date-damon")
                               (:file "list-impures-by-deamon")
                               (:file "list-relational-impures-by-impure")
                               (:file "list-summary-purge-by-angel-deamon-span")
                               (:file "list-summary-purge-by-angel-span")
                               (:file "list-summary-purge-by-angel-impure-span"))))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "holy-water-test"))))
