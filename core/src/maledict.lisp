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
