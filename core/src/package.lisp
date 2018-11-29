(defpackage holy-water
  (:nicknames :hw)
  (:use #:cl)
  (:import-from :alexandria
                #:when-let)
  (:import-from :mito
                #:find-dao
                #:select-dao
                #:create-dao
                #:save-dao
                #:delete-dao
                #:object-id
                #:object-updated-at)
  (:import-from :sxql
                #:select
                #:from
                #:where
                #:inner-join
                #:union-all-queries)
  (:export #:find-maledicts
           #:get-maledict
           #:get-maledict-type
           #:get-maledict-done)
  (:export #:find-impures
           #:create-impure
           #:add-impure
           #:get-impure
           #:save-impure)
  (:export #:find-angels
           #:get-angel
           #:get-angel-at-auth)
  (:export #:get-purge
           #:find-purge-history
           #:save-purge-term)
  (:export #:start-action-impure
           #:stop-action-impure
           #:finish-impure
           #:move-impure))
(in-package :holy-water)

(mito:connect-toplevel :postgres :database-name "holy_water" :username "holy_water")
