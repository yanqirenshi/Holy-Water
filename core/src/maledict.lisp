(in-package :holy-water)

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
