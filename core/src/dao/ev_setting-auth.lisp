(in-package :holy-water)

(defclass ev_setting-auth ()
  ((angel-id   :col-type :bigserial     :accessor angel-id)
   (email      :col-type (:varchar 255) :accessor email)
   (password   :col-type (:varchar 255) :accessor password)
   (created-by :col-type :bigserial     :accessor created-by)
   (updated-by :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))
