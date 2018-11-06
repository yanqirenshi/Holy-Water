#|
  This file is a part of holy-water.core project.
|#

(defsystem "holy-water.core-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("holy-water.core"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "holy-water.core"))))
  :description "Test system for holy-water.core"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
