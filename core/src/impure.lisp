(in-package :holy-water)

(defun create-impure (&key creator
                          (name "????????")
                          (description ""))
  (let ((by-id (creator-id creator)))
    (mito:create-dao 'rs_impure
                     :name name
                     :description description
                     :created-by by-id
                     :updated-by by-id)))


(defgeneric add-impure (target impure &key creator)
  (:method ((maledict rs_maledict) (impure rs_impure) &key creator)
    (collect-impure-create maledict impure :creator creator))
  (:method ((angel rs_angel) (impure rs_impure) &key creator)
    (let ((inbox (get-inbox-maledict angel)))
      (add-impure inbox impure :creator creator))))
