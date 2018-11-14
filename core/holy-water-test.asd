#|
  This file is a part of holy-water project.
|#

(defsystem "holy-water-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("holy-water"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "holy-water"))))
  :description "Test system for holy-water"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
