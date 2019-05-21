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
                #:left-join
                #:group-by
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
           #:add-after-impure
           #:impure-set-deamon)
  (:export #:find-orthodoxs
           #:get-orthodox)
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
           #:create-incantation-duet)
  (:export #:list-summay-purge-time-by-date-damon
           #:list-purge-by-angel
           #:list-cemeteries
           #:list-summay-impure-cemeteries-by-date-damon
           #:list-summary-purge-by-deamon))
(in-package :holy-water)

(mito:connect-toplevel :postgres :database-name "holy_water" :username "holy_water")

(defun timestamptz2timestamp (v)
  (local-time:format-timestring nil (local-time:universal-to-timestamp v)))

(defun timestamptz2timestamp! (plist indicator)
  (setf (getf plist indicator)
   (timestamptz2timestamp (getf plist indicator))))

(defun interval2second (v)
  (second (assoc :seconds v)))

(defun interval2second! (plist indicator)
  (setf (getf plist indicator)
        (interval2second (getf plist indicator)))
  plist)

(defun fetch-all-list (sxql &key infrate infrate!)
  (multiple-value-bind (sxql vals)
      (sxql:yield sxql)
    (let ((results (fetch-list sxql vals)))
      (cond (infrate  (mapcar #'(lambda (rec) (funcall infrate rec)) results))
            (infrate! (dolist (rec results)
                        (funcall infrate! rec))
                      results)))))

