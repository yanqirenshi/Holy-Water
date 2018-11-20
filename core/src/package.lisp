(defpackage holy-water
  (:nicknames :hw)
  (:use #:cl)
  (:import-from :alexandria
                #:when-let)
  (:export #:find-maledicts
           #:get-maledict
           #:get-maledict-type)
  (:export #:find-impures
           #:create-impure
           #:add-impure
           #:get-impure)
  (:export #:get-angel)
  (:export #:get-purge)
  (:export #:start-action-impure
           #:stop-action-impure
           #:finish-impure))
(in-package :holy-water)

(mito:connect-toplevel :postgres :database-name "holy_water" :username "holy_water")
