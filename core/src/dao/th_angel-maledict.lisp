(in-package :holy-water)

(defclass th_angel-maledict ()
  ((angel-id    :col-type :bigserial     :accessor angel-id)
   (maledict-id :col-type :bigserial     :accessor maledict-id)
   ;;
   (created-by  :col-type :bigserial     :accessor created-by)
   (updated-by  :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))
