(in-package :holy-water)

;; (defclass ev_purge-start ()
;;   ((angel-id    :accessor angel-id)
;;    (activity-id :accessor activity-id)
;;    (description :accessor description)
;;    (start       :accessor start)
;;    (end         :accessor end)
;;    ;;
;;    (created-by  :accessor created-by)
;;    (updated-by  :accessor updated-by)))

(defclass ev_purge-start ()
  ((angel-id    :col-type :bigserial   :accessor angel-id)
   (impure-id   :col-type :bigserial   :accessor impure-id)
   (description :col-type :text        :accessor description)
   (start       :col-type :timestamptz :accessor start)
   ;;
   (created-by  :col-type :bigserial   :accessor created-by)
   (updated-by  :col-type :bigserial   :accessor updated-by))
  (:metaclass mito:dao-table-class))

(defclass ev_purge-end ()
  ((angel-id    :col-type :bigserial   :accessor angel-id)
   (impure-id   :col-type :bigserial   :accessor impure-id)
   (description :col-type :text        :accessor description)
   (start       :col-type :timestamptz :accessor start)
   (end         :col-type :timestamptz :accessor end)
   ;;
   (created-by  :col-type :bigserial   :accessor created-by)
   (updated-by  :col-type :bigserial   :accessor updated-by))
  (:metaclass mito:dao-table-class))
