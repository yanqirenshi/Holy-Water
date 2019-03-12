(in-package :holy-water)

(defclass re_impure ()
  ((id-parent   :col-type :bigserial :accessor id-parent)
   (id-child    :col-type :bigserial :accessor id-child)
   ;;
   (created-by  :col-type :bigserial :accessor created-by)
   (updated-by  :col-type :bigserial :accessor updated-by))
  (:metaclass mito:dao-table-class))
