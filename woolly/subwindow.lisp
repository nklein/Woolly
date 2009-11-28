
(in-package #:woolly)

(sheeple:defproto =subwindow= (=container=)
  ((title "Little Woolly")
   closed
   dragging))

(sheeple:defreply floating ((item =subwindow=))
  (declare (ignore item))
  t)

(sheeple:defreply mouse-move ((item =subwindow=) xx yy)
  (let ((dragging (dragging item)))
    (when dragging
      (let ((dx (- xx (car dragging)))
	    (dy (- yy (cdr dragging))))
	(incf (offset-x item) dx)
	(incf (offset-y item) dy))
      (when (< (offset-x item) 0) (setf (offset-x item) 0))
      (when (< (offset-y item) 0) (setf (offset-y item) 0))
      t)))
