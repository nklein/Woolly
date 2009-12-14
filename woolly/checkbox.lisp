
(in-package #:woolly)

(sheeple:defproto =checkbox= (=button=)
  (pushed))

(sheeple:defreply clicked ((checkbox =checkbox=) mouse-button xx yy)
  (declare (ignore mouse-button xx yy))
  (setf (pushed checkbox) (not (pushed checkbox)))
  t)
