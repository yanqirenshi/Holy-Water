(in-package :holy-water)

(defclass th_orthodox_angel ()
  ((orthodox-id :col-type :bigserial :accessor orthodox-id)
   (angel-id    :col-type :bigserial :accessor angel-id)
   ;;
   (created-by  :col-type :bigserial     :accessor created-by)
   (updated-by  :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))
