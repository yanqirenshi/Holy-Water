(in-package :holy-water)

(defclass th_orthodox_angel ()
  ((orthodox-id      :col-type :bigserial   :accessor orthodox-id)
   (orthodox-duty-id :col-type :bigserial   :accessor orthodox-duty-id)
   (angel-id         :col-type :bigserial   :accessor angel-id)
   (appointed-at     :col-type :timestamptz :accessor appointed-at :initform (local-time:now))
   ;;
   (created-by       :col-type :bigserial   :accessor created-by)
   (updated-by       :col-type :bigserial   :accessor updated-by))
  (:metaclass mito:dao-table-class))
