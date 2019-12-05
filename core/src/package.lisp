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
  (:export #:*db-name*
           #:*db-user*
           #:*db-user-password*)
  (:export #:find-deamons
           #:create-deamon
           #:purge-deamon)
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
           #:add-deamon-impure
           #:impure-set-deamon)
  (:export #:find-orthodoxs
           #:get-orthodox
           #:find-orthodox-duties)
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
           #:create-request
           #:create-request-message
           #:find-impure-request-messages)
  (:export #:find-deccots
           #:get-angel-deccot
           #:find-deccot-items)
  (:export #:create-incantation-solo
           #:create-incantation-duet)
  (:export #:list-summay-purge-time-by-date-damon
           #:list-purge-by-angel
           #:list-purge-by-impure
           #:list-cemeteries
           #:list-summay-impure-cemeteries-by-date-damon
           #:list-summary-purge-by-deamon
           #:list-summary-purge-by-impure
           #:list-requested-uncomplete-impures
           #:list-request-messages-unred
           #:list-maledict-impures
           #:list-orthodox-angels
           #:list-impures-by-deamon
           #:list-impures-purged-time-by-deamon
           #:list-relational-impures-by-impure
           #:list-summary-purge-by-angel-deamon-span
           #:list-summary-purge-by-angel-impure-span
           #:list-summary-purge-by-angel-span))
(in-package :holy-water)

(defun timestamptz2timestamp (v)
  (local-time:format-timestring nil (local-time:universal-to-timestamp v)))

(defun timestamptz2timestamp! (plist indicator)
  (let ((val (getf plist indicator)))
    (cond ((eq :null val) val)
          (t (when val
               (setf (getf plist indicator)
                     (timestamptz2timestamp val)))))))

(defun interval2second (v)
  (cond ((eq :null v) v)
        (t (second (assoc :seconds v)))))

(defun interval2second! (plist indicator)
  (setf (getf plist indicator)
        (interval2second (getf plist indicator)))
  plist)

(defun apply-infrate! (func results)
  (dolist (rec results)
    (funcall func rec))
  results)

(defun fetch-all-list (sxql &key infrate infrate!)
  (multiple-value-bind (sxql vals)
      (sxql:yield sxql)
    (let ((results (fetch-list sxql vals)))
      (cond (infrate  (mapcar #'(lambda (rec) (funcall infrate rec)) results))
            (infrate! (apply-infrate! infrate! results))
            (t results)))))
