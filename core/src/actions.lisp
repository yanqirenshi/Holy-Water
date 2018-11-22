(in-package :holy-water)

;;;;;
;;;;; Start Impure
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
;;;;; Stop Impure
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


;;;;;
;;;;; Move Impure
;;;;;
(defun %move-impure (angel impure to-maledict &key editor)
  (let ((collect-impure (get-collect-impure :angel angel :impure impure)))
    (unless collect-impure (error "あかん!"))
    ;; change maldect
    (setf (maledict-id collect-impure) (mito:object-id to-maledict))
    (setf (updated-by  collect-impure) (mito:object-id to-maledict))
    (mito:save-dao collect-impure)
    ;; add history
    (format t "1------~%")
    (create-collect-impure-history collect-impure :editor editor)
    (format t "2------~%")
    impure))

(defgeneric move-impure (angel impure to-maledict &key editor)
  (:method (angel (impure rs_impure-active) (to-maledict rs_maledict) &key editor)
    (%move-impure angel impure to-maledict :editor editor))
  (:method (angel (impure rs_impure-finished) (to-maledict rs_maledict) &key editor)
    (declare (ignore angel editor to-maledict))
    (error "完了済みです。 impure=~S" impure))
  (:method (angel (impure rs_impure-discarded) (to-maledict rs_maledict) &key editor)
    (declare (ignore angel editor to-maledict))
    (error "削除済みです。 impure=~S" impure)))


;;;;;
;;;;; Finish Impure
;;;;;
(defun %finish-impure (angel impure &key editor)
  (let ((done-maledict (get-maledict-done :angel angel))
        (done-impure   (make-impure-finished impure :editor editor)))
    (move-impure angel impure done-maledict :editor editor)
    (mito:delete-dao impure)
    (mito:save-dao   done-impure)
    done-impure))

(defgeneric finish-impure (angel impure &key editor)
  (:method (angel (impure rs_impure-active) &key editor)
    (%finish-impure angel impure :editor editor))

  (:method (angel (impure rs_impure-finished) &key editor)
    (declare (ignore angel editor))
    (error "完了済みです。 impure=~S" impure))

  (:method (angel (impure rs_impure-discarded) &key editor)
    (declare (ignore angel editor))
    (error "削除済みです。 impure=~S" impure)))
