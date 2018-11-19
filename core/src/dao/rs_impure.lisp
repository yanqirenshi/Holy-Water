(in-package :holy-water)

;; (defclass rs_impure ()
;;   ((name         :accessor name)
;;    (description  :accessor description)
;;    (finished-at  :accessor finished-at)
;;    (discarded-at :accessor finished-at)
;;    ;;
;;    (created-by   :accessor created-by)
;;    (updated-by   :accessor updated-by)))

(defclass rs_impure-active ()
  ((name        :col-type (:varchar 255) :accessor name)
   (description :col-type :text          :accessor description)
   ;;
   (created-by  :col-type :bigserial     :accessor created-by)
   (updated-by  :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))

(defclass rs_impure-finished ()
  ((name        :col-type (:varchar 255) :accessor name)
   (description :col-type :text          :accessor description)
   (finished-at :col-type :datetime      :accessor finished-at)
   ;;
   (created-by  :col-type :bigserial     :accessor created-by)
   (updated-by  :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))

(defclass rs_impure-discarded ()
  ((name         :col-type (:varchar 255) :accessor name)
   (description  :col-type :text          :accessor description)
   (discarded-at :col-type :datetime      :accessor discarded-at)
   ;;
   (created-by   :col-type :bigserial     :accessor created-by)
   (updated-by   :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))
