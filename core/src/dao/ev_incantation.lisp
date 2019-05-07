(in-package :holy-water)


(defclass ev_incantation-solo ()
  ((impure-id      :col-type :bigserial   :accessor impure-id)
   (angel-id       :col-type :bigserial   :accessor angel-id)
   (spell          :col-type :text        :accessor spell)
   (incantation-at :col-type :timestamptz :accessor incantation-at)
   ;;
   (created-by     :col-type :bigserial   :accessor created-by)
   (updated-by     :col-type :bigserial   :accessor updated-by))
  (:metaclass mito:dao-table-class))


(defclass ev_incantation-duet ()
  ((impure-id      :col-type :bigserial   :accessor impure-id)
   (angel-id-ena   :col-type :bigserial   :accessor angel-id-ena)
   (angel-id-duo   :col-type :bigserial   :accessor angel-id-duo)
   (spell          :col-type :text        :accessor spell)
   (incantation-at :col-type :timestamptz :accessor incantation-at)
   ;;
   (created-by     :col-type :bigserial   :accessor created-by)
   (updated-by     :col-type :bigserial   :accessor updated-by))
  (:metaclass mito:dao-table-class))
