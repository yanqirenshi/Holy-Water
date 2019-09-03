(in-package :holy-water)

(defvar *db-name* nil)
(defvar *db-user* nil)
(defvar *db-user-password* nil)

(defun connect-db ()
  (mito:connect-toplevel :postgres
                         :database-name *db-name*
                         :username *db-user*
                         :password *db-user-password*))
