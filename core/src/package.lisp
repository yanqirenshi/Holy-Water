(defpackage holy-water
  (:nicknames :hw)
  (:use #:cl)
  (:export #:find-maledicts
           #:get-maledict
           #:get-maledict-type)
  (:export #:find-impures
           #:create-impure
           #:add-impure)
  (:export #:get-angel))
(in-package :holy-water)

(mito:connect-toplevel :postgres :database-name "holy_water" :username "holy_water")
