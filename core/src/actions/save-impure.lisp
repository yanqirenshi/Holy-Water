(in-package :holy-water)


(defgeneric save-impure (angel impure &key name description editor)
  (:method (angel (impure rs_impure-active) &key name description editor)
    (setf (name impure) name)
    (setf (description impure) description)
    (setf (updated-by impure) (object-id editor))
    (save-dao impure)
    impure))
