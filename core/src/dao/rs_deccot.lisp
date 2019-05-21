(in-package :holy-water)

(defclass rs_deccot ()
  ((created-by   :accessor created-by)
   (updated-by   :accessor updated-by)))

(defclass rs_deccot-gitlab (rs_deccot)
  ((private-token :col-type (:varchar 255) :accessor private-token))
  (:metaclass mito:dao-table-class))

(defclass rs_deccot-github (rs_deccot)
  ((oauth-token :col-type (:varchar 255) :accessor oauth-token))
  (:metaclass mito:dao-table-class))
