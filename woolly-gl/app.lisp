(in-package #:woolly-gl)

(sheeple:defproto =app= (woolly:=app=)
  ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-condition exit-main-loop-condition (condition)
  ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sheeple:defreply woolly:main-loop ((app =app=))
  (declare (ignore app))
  (handler-case (glut:main-loop)
    (exit-main-loop-condition () nil)))

(sheeple:defreply woolly:exit-main-loop ((app =app=))
  (error 'exit-main-loop-condition))
