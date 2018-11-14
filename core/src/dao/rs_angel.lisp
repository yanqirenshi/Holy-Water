(in-package :holy-water)

(defclass rs_angel ()
  ((name       :col-type (:varchar 255) :accessor name)
   ;;
   (created-by :col-type :bigserial     :accessor created-by)
   (updated-by :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))
