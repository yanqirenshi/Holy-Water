(in-package :holy-water)


(defun %move-impure (angel impure to-maledict &key editor)
  (let ((collect-impure (get-collect-impure :angel angel :impure impure)))
    (unless collect-impure
      (error "あかん! あんたんちゃうわ。impure=~S" impure))
    ;; change maldect
    (setf (maledict-id collect-impure) (object-id to-maledict))
    (setf (updated-by  collect-impure) (object-id to-maledict))
    (save-dao collect-impure)
    ;; add history
    (create-collect-impure-history collect-impure :editor editor)
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
