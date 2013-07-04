

; the clean, functional part
(defun add-widget (database widget)
  (cons widget database))

; the dirty, non-functional part
(defparameter *database* nil)

(defun main-loop ()
  (loop (princ "Please enter the name of a new widget: ")
        (setf *database* (add-widget *database* (read)))
        (format t "The database contains the following: ~a~%" *database*)))
