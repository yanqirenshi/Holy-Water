(in-package :holy-water)

(defclass rs_maledict ()
  ((name       :col-type (:varchar 255) :accessor name)
   (order      :col-type :integer       :accessor order)
   (deletable  :col-type :integer       :accessor mutable)
   ;; 
   (created-by :col-type :bigserial :accessor created-by)
   (updated-by :col-type :bigserial :accessor updated-by))
  (:metaclass mito:dao-table-class))
