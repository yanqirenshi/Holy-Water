(in-package :holy-water)

(defclass rs_maledict ()
  ((maledict-type-id :col-type :bigserial     :accessor maledict-type-id)
   (name             :col-type (:varchar 255) :accessor name)
   (description      :col-type :text          :accessor description)
   (order            :col-type :integer       :accessor order)
   (deletable        :col-type :integer       :accessor deletable)
   ;;
   (created-by :col-type :bigserial :accessor created-by)
   (updated-by :col-type :bigserial :accessor updated-by))
  (:metaclass mito:dao-table-class))
