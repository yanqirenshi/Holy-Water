(in-package :holy-water)

(defclass rs_impure ()
  ((name        :col-type (:varchar 255) :accessor name)
   (description :col-type :text          :accessor description)
   ;;
   (created-by  :col-type :bigserial     :accessor created-by)
   (updated-by  :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))
