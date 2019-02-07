(in-package :holy-water)

(defclass th_deamon-impure ()
  ((deamon-id :col-type :bigserial :accessor deamon-id)
   (impure-id :col-type :bigserial :accessor impure-id)
   ;;
   (created-by  :col-type :bigserial     :accessor created-by)
   (updated-by  :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))
