(in-package :holy-water)

;;;;;
;;;;; start
;;;;;
(defun %start-action-impure (angel impure &key editor)
  (let ((started (get-purge :status :start :angel angel :impure impure)))
    ;; TODO: angel のバケットにあること
    (when started
      (error "すでにすでに開始しています。purge=~S" started))
    (create-purge-start angel impure :editor editor)
    impure))

(defgeneric start-action-impure (angel impure &key editor)
  (:method (angel (impure rs_impure-active) &key editor)
    (%start-action-impure angel impure :editor editor))
  (:method (angel (impure rs_impure-finished) &key editor)
    (declare (ignore angel editor))
    (error "完了済みです。 impure=~S" impure))
  (:method (angel (impure rs_impure-discarded) &key editor)
    (declare (ignore angel editor))
    (error "削除済みです。 impure=~S" impure)))


;;;;;
;;;;; stop
;;;;;
(defun %stop-action-impure (angel impure &key editor)
  (let ((started (get-purge :status :start :angel angel :impure impure)))
    (when started
      (create-purge-end angel started :editor editor)
      impure)))

(defgeneric stop-action-impure (angel impure &key editor)
  (:method (angel (impure rs_impure-active) &key editor)
    (%stop-action-impure angel impure :editor editor))
  (:method (angel (impure rs_impure-finished) &key editor)
    (declare (ignore angel editor))
    (error "完了済みです。 impure=~S" impure))
  (:method (angel (impure rs_impure-discarded) &key editor)
    (declare (ignore angel editor))
    (error "削除済みです。 impure=~S" impure)))
