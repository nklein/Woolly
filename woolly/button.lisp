
(in-package #:woolly)

(sheeple:defproto =button= (=widget=)
  ())

(sheeple:defreply mousedown ((button =button=) mouse-button xx yy)
  (declare (ignore button mouse-button xx yy))
  t)

(sheeple:defreply mouseup ((button =button=) mouse-button xx yy)
  (declare (ignore mouse-button))
  (when (and (< -1 xx (width button))
	     (< -1 yy (height button)))
    (format t "~S: Clicked~%" button))
  t)
