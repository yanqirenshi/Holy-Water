(in-package :holy-water)

(defclass ev_request ()
  ((impure-id     :col-type :bigserial   :accessor impure-id)
   (angel-id-from :col-type :bigserial   :accessor angel-id-from)
   (angel-id-to   :col-type :bigserial   :accessor angel-id-to)
   (requested-at  :col-type :timestamptz :accessor requested-at)
   ;;
   (created-by    :col-type :bigserial   :accessor created-by)
   (updated-by    :col-type :bigserial   :accessor updated-by))
  (:metaclass mito:dao-table-class))

(defclass ev_request-message-unread ()
  ((impure-id     :col-type :bigserial   :accessor impure-id)
   (angel-id-from :col-type :bigserial   :accessor angel-id-from)
   (angel-id-to   :col-type :bigserial   :accessor angel-id-to)
   (contents      :col-type :text        :accessor contents)
   (messaged-at   :col-type :timestamptz :accessor messaged-at)
   ;;
   (created-by    :col-type :bigserial   :accessor created-by)
   (updated-by    :col-type :bigserial   :accessor updated-by)
   ;;
   (request-id     :col-type :bigserial   :accessor request-id))
  (:metaclass mito:dao-table-class))

(defclass ev_request-message-read ()
  ((impure-id     :col-type :bigserial   :accessor impure-id)
   (angel-id-from :col-type :bigserial   :accessor angel-id-from)
   (angel-id-to   :col-type :bigserial   :accessor angel-id-to)
   (contents      :col-type :text        :accessor contents)
   (messaged-at   :col-type :timestamptz :accessor messaged-at)
   (readed-at     :col-type :timestamptz :accessor readed-at)
   ;;
   (created-by    :col-type :bigserial   :accessor created-by)
   (updated-by    :col-type :bigserial   :accessor updated-by)
   ;;
   (request-id     :col-type :bigserial   :accessor request-id))
  (:metaclass mito:dao-table-class))
