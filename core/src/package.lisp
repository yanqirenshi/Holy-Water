(defpackage holy-water
  (:use :cl))
(in-package :holy-water)

(mito:connect-toplevel :postgres :database-name "holy_water" :username "holy_water")
