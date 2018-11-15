(in-package :holy-water)

(defclass ev_collect-impure ()
  ((maledict-id :col-type :bigserial     :accessor maledict-id)
   (impure-id   :col-type :bigserial     :accessor impure-id)
   (start       :col-type :datetime      :accessor start :initform (local-time:now))
   ;;
   (created-by  :col-type :bigserial     :accessor created-by)
   (updated-by  :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))

(defclass ev_collect-impure-history ()
  ((maledict-id :col-type :bigserial     :accessor maledict-id)
   (impure-id   :col-type :bigserial     :accessor angel-id)
   (start       :col-type :timestamp     :accessor start)
   (end         :col-type :timestamp     :accessor end)
   ;;
   (created-by  :col-type :bigserial     :accessor created-by)
   (updated-by  :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))
