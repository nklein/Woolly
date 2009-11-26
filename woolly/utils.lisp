
(in-package #:woolly)

(defmacro set? ( &rest pairs )
  (flet ((do-pair (place value)
	   (let ((vv (gensym "VALUE-")))
	     `(let ((,vv ,value))
		(when ,vv (setf ,place ,vv))))))
    `(progn ,@(loop :for ll :on pairs :by #'cddr
		 :collecting (do-pair (first ll) (second ll))))))

