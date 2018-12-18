(in-package :holy-water)

(defun stop-actioning-impure (angel &key editor)
  (let ((impure (get-impure-purging angel)))
    (when impure
      (stop-action-impure angel impure :editor editor))
    impure))

(defun assert-started-purge-impure (angel impure)
  (let ((started (get-purge :status :start :angel angel :impure impure)))
    (when started
      (error "すでにすでに開始しています。purge=~S" started))))

(defun %start-action-impure (angel impure &key editor)
  (let ((stopped-impure (stop-actioning-impure angel :editor editor)))
    ;; TODO: angel のバケットにあること
    (assert-started-purge-impure angel impure)
    (create-purge-start angel impure :editor editor)
    (values impure stopped-impure)))

(defgeneric start-action-impure (angel impure &key editor)
  (:method (angel (impure rs_impure-active) &key editor)
    (%start-action-impure angel impure :editor editor))
  (:method (angel (impure rs_impure-finished) &key editor)
    (declare (ignore angel editor))
    (error "完了済みです。 impure=~S" impure))
  (:method (angel (impure rs_impure-discarded) &key editor)
    (declare (ignore angel editor))
    (error "削除済みです。 impure=~S" impure)))
