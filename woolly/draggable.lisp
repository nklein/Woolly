
(in-package #:woolly)

(sheeple:defproto =draggable= (=widget=)
  (dragging))

(sheeple:defreply sheeple:init-object :after ((dd =draggable=)
					      &key
					      &allow-other-keys)
  (setf (dragging dd) nil))

(sheeple:defreply floating ((item =draggable=))
  (declare (ignore item))
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(sheeple:defreply mouse-move ((item =draggable=) xx yy)
  (let ((dragging (dragging item)))
    (when dragging
      (let ((dx (- xx (car dragging)))
	    (dy (- yy (cdr dragging))))
	(incf (offset-x item) dx)
	(incf (offset-y item) dy))
      (let ((pp (parent item)))
	(when pp
	  (when (< (width pp) (+ (offset-x item) (width item)))
	    (setf (offset-x item) (- (width pp) (width item))))
	  (when (< (height pp) (+ (offset-y item) (height item)))
	    (setf (offset-y item) (- (height pp) (height item))))))
      (when (< (offset-x item) 0) (setf (offset-x item) 0))
      (when (< (offset-y item) 0) (setf (offset-y item) 0))
      t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(sheeple:defreply woolly:mouse-down ((dd =draggable=) mb xx yy)
  (setf (dragging dd) (cons xx yy)))
