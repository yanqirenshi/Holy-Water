#|
  This file is a part of holy-water.api project.
|#

(defsystem "holy-water.api-test"
  :defsystem-depends-on ("prove-asdf")
  :author ""
  :license ""
  :depends-on ("holy-water.api"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "holy-water.api"))))
  :description "Test system for holy-water.api"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
