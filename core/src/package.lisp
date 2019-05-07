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
  (:export #:find-deamons)
  (:export #:find-maledicts
           #:get-maledict
           #:get-maledict-type
           #:get-maledict-done)
  (:export #:create-impure
           #:add-impure
           #:get-impure
           #:save-impure
           #:find-impures
           #:find-impures-cemetery
           #:add-after-impure)
  (:export #:find-orthodoxs)
  (:export #:find-angels
           #:get-angel
           #:get-angel-at-auth
           #:get-angel-at-ghost-shadow-id
           #:angel-impure)
  (:export #:get-purge
           #:find-purge-history
           #:save-purge-term)
  (:export #:start-action-impure
           #:stop-action-impure
           #:finish-impure
           #:move-impure
           #:get-request-message
           #:create-request-message
           #:find-impure-request-messages)
  (:export #:find-deccots
           #:get-angel-deccot
           #:find-deccot-items)
  (:export #:create-incantation-solo
           #:create-incantation-duet))
(in-package :holy-water)

(mito:connect-toplevel :postgres :database-name "holy_water" :username "holy_water")
