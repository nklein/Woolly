
(in-package #:woolly)

(sheeple:defproto =checkbox= (=button=)
  (pushed))

(sheeple:defreply sheeple:init-object :after ((checkbox =checkbox=)
					      &key (pushed nil pushed-p)
					      &allow-other-keys)
  (when pushed-p
    (setf (pushed checkbox) pushed)))

(sheeple:defreply clicked ((checkbox =checkbox=) mouse-button xx yy)
  (declare (ignore mouse-button xx yy))
  (setf (pushed checkbox) (not (pushed checkbox)))
  t)
