(in-package :holy-water)

(defclass rs_ghost-shadow ()
  ((ghost-id   :col-type :integer   :accessor ghost-id)
   ;;
   (created-by :col-type :bigserial :accessor created-by)
   (updated-by :col-type :bigserial :accessor updated-by))
  (:metaclass mito:dao-table-class))
