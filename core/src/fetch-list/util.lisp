(in-package :holy-water)

(defun fetch-list (sql vals)
  (dbi:fetch-all (apply #'dbi:execute (dbi:prepare mito:*connection* sql) vals)))
