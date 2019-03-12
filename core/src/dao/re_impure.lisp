(in-package :holy-water)

(defclass re_impure ()
  ((id-from     :col-type :bigserial :accessor id-from)
   (id-to       :col-type :bigserial :accessor id-to)
   ;;
   (created-by  :col-type :bigserial :accessor created-by)
   (updated-by  :col-type :bigserial :accessor updated-by))
  (:metaclass mito:dao-table-class))
