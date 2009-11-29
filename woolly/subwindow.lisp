
(in-package #:woolly)

(sheeple:defproto =subwindow= (=widget=)
  ((title "Little Woolly")
   closed
   dragging
   container))

(sheeple:defreply sheeple:init-object :after ((ss =subwindow=)
					      &key title
					           closed
					      &allow-other-keys)
  (set? (title ss) title
        (closed ss) closed)
  (setf (dragging ss) nil
	(container ss) (sheeple:object :parents =container=)))

(sheeple:defreply floating ((item =subwindow=))
  (declare (ignore item))
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(sheeple:defreply add ((ss =subwindow=) (widget =widget=))
  (add (container ss) widget))

(sheeple:defreply children ((ss =subwindow=))
  (children (container ss)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
