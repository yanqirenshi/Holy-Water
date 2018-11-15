(defpackage holy-water
  (:nicknames :hw)
  (:use #:cl)
  (:export #:find-maledicts
           #:get-maledict-type)
  (:export #:find-impures
           #:get-maledict))
(in-package :holy-water)

(mito:connect-toplevel :postgres :database-name "holy_water" :username "holy_water")
