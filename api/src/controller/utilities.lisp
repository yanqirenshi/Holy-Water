(in-package :holy-water.api.controller)

(defun timestamp2str (ts)
  (cond ((null ts) :null)
        ((eq :null ts) ts)
        (t (local-time:format-timestring nil ts))))

(defun ut2timestamp (ut)
  (local-time:universal-to-timestamp ut))

(defun ut2str (ut)
  (when ut
    (timestamp2str (ut2timestamp ut))))
