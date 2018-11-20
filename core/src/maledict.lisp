(in-package :holy-water)

(defun get-maledict (&key id)
  (when id
    (mito:find-dao 'rs_maledict :id id)))

(defun find-maledicts ()
  (mito:select-dao 'rs_maledict))

(defun get-maledict-type (&key maledict)
  (gethash (maledict-type-id maledict) *maledict-types*))

(defun create-maledict (&key creator
                          maledict-type-id
                          (name "????????")
                          (order 1)
                          (deletable nil)
                          (description ""))
  (let ((by-id (creator-id creator)))
    (mito:create-dao 'rs_maledict
                     :maledict-type-id maledict-type-id
                     :name name
                     :description description
                     :order order
                     :deletable deletable
                     :created-by by-id
                     :updated-by by-id)))


(defun get-maledict-done (&key angel)
  (when angel
    (car (mito:select-dao 'rs_maledict
           (sxql:inner-join :th_angel_maledict
                            :on (:= :rs_maledict.id :th_angel_maledict.maledict-id))
           (sxql:where (:and (:= :th_angel_maledict.angel-id
                                 (mito:object-id angel))
                             (:= :rs_maledict.maledict-type-id
                                 *maledict-type-done*)))))))
