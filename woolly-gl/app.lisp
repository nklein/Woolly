(in-package #:woolly-gl)

(sheeple:defproto =app= (woolly:=app=)
  ())

(sheeple:defreply woolly:main-loop ((app =app=))
  (declare (ignore app))
  (handler-case (glut:main-loop)
    (exit-main-loop-condition () nil)))
