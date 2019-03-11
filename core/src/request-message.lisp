(in-package :holy-water)

(defun create-request-message (impure angel-from angel-to message)
  (mito:create-dao 'ev_request-message
                   :impure-id     (mito:object-id impure)
                   :angel-id-from (mito:object-id angel-from)
                   :angel-id-to   (mito:object-id angel-to)
                   :contents      message
                   :messaged-at   (local-time:now)))
