(in-package :holy-water)

(defgeneric create-angel-maledict (creator angel maledict)
  (:method ((creator rs_angel) (angel rs_angel) (maledict rs_maledict))
    (let ((by (mito:object-id creator)))
      (mito:create-dao 'th_angel-maledict
                       :angel-id (mito:object-id angel)
                       :maledict-id (mito:object-id maledict)
                       :created-by by
                       :updated-by by))))
