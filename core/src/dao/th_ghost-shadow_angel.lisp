(in-package :holy-water)

(defclass th_ghost-shadow_angel ()
  ((ghost-shadow-id :col-type :bigserial :accessor ghost-shadow-id)
   (angel-id        :col-type :bigserial :accessor angel-id)
   ;;
   (created-by  :col-type :bigserial     :accessor created-by)
   (updated-by  :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))
