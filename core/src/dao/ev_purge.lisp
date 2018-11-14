(in-package :holy-water)

(defclass ev_purge-start ()
  ((angel-id    :col-type :bigserial :accessor angel-id)
   (activity-id :col-type :bigserial :accessor activity-id)
   (description :col-type :text      :accessor description)
   (start       :col-type :datetime  :accessor start)
   ;;
   (created-by  :col-type :bigserial :accessor created-by)
   (updated-by  :col-type :bigserial :accessor updated-by))
  (:metaclass mito:dao-table-class))

(defclass ev_purge-end ()
  ((angel-id    :col-type :bigserial :accessor angel-id)
   (impure-id   :col-type :bigserial :accessor impure-id)
   (description :col-type :text      :accessor description)
   (start       :col-type :datetime  :accessor start)
   (end         :col-type :datetime  :accessor end)
   ;;
   (created-by  :col-type :bigserial :accessor created-by)
   (updated-by  :col-type :bigserial :accessor updated-by))
  (:metaclass mito:dao-table-class))
