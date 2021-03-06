(in-package :holy-water)

(defvar *tables-rs_impure* '(:rs_impure_active :rs_impure_finished :rs_impure_discarded))

(defclass rs_impure ()
  ((name         :accessor name)
   (description  :accessor description)
   ;;
   (created-by   :accessor created-by)
   (updated-by   :accessor updated-by)))

(defclass rs_impure-active (rs_impure)
  ((name        :col-type (:varchar 255) :accessor name)
   (description :col-type :text          :accessor description)
   ;;
   (created-by  :col-type :bigserial     :accessor created-by)
   (updated-by  :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))

(defclass rs_impure-finished (rs_impure)
  ((name        :col-type (:varchar 255) :accessor name)
   (description :col-type :text          :accessor description)
   (finished-at :col-type :timestamptz   :accessor finished-at)
   (finished-by :col-type :bigserial     :accessor finished-by)
   ;;
   (created-by  :col-type :bigserial     :accessor created-by)
   (updated-by  :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))

(defclass rs_impure-discarded (rs_impure)
  ((name         :col-type (:varchar 255) :accessor name)
   (description  :col-type :text          :accessor description)
   (discarded-at :col-type :timestamptz   :accessor discarded-at)
   ;;
   (created-by   :col-type :bigserial     :accessor created-by)
   (updated-by   :col-type :bigserial     :accessor updated-by))
  (:metaclass mito:dao-table-class))
