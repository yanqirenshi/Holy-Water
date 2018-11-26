(in-package :holy-water.api.controller)

(defun timestamp2str (ts)
  (if ts
      (local-time:format-timestring nil ts)
      :null))

(defun ut2timestamp (ut)
  (local-time:universal-to-timestamp ut))

(defun ut2str (ut)
  (when ut
    (timestamp2str (ut2timestamp ut))))

