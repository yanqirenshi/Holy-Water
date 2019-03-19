(in-package :holy-water)

(defclass th_ghost-shadow_deccot ()
  ((ghost-shadow-id :col-type :bigserial :accessor ghost-shadow-id)
   (deccot-id       :col-type :bigserial :accessor deccot-id)
   ;;
   (created-by      :col-type :bigserial :accessor created-by)
   (updated-by      :col-type :bigserial :accessor updated-by))
  (:metaclass mito:dao-table-class))
