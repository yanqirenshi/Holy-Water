(in-package :holy-water)

(defgeneric creator-id (creator)
  (:method ((creator rs_angel))
    (object-id creator))
  (:method ((creator (eql :initial)))
    0))
