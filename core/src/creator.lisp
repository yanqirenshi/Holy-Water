(in-package :holy-water)

(defgeneric creator-id (creator)
  (:method ((creator rs_angel))
    (mito:object-id creator))
  (:method ((creator (eql :initial)))
    0))
