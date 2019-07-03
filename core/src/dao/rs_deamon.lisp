(in-package :holy-water)

(defclass rs_deamon ()
  ((name        :col-type (:varchar 255) :accessor name)
   (name-short  :col-type (:varchar 255) :accessor name-short)
   (description :col-type :text          :accessor description)
   ;;
   (created-by  :col-type :bigserial     :accessor created-by)
   (updated-by  :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))
