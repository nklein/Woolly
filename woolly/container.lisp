
(in-package #:woolly)

(sheeple:defproto =container= (=widget=)
  (children
   mouse-active))

(sheeple:defmessage add (container widget)
  (:documentation "Add the WIDGET to the given CONTAINER"))

(sheeple:defreply add ((container =container=) (widget =widget=))
  (setf (parent widget) container)
  (pushnew widget (children container)))

(defun put-floating-first (children)
  (labels ((floating-p (cc)
	     (floating cc)))
    (append (remove-if-not #'floating-p children)
	    (remove-if #'floating-p children))))

(sheeple:defreply draw ((container =container=))
  (mapc #'(lambda (item) (draw item))
	(reverse (put-floating-first (children container)))))

(sheeple:defreply mouse-down ((container =container=) button xx yy)
  "When a container gets a mousedown message, it has to see if any of its
   children would like to accept the mousedown event.  If they do, it
   has to remember which one so that it can properly route the mouseup
   event later."
  (labels ((mouse-hit (kid xx yy)
	     (and (<= (offset-x kid) xx (+ (offset-x kid) (width kid) -1))
		  (<= (offset-y kid) yy (+ (offset-y kid) (height kid) -1))))
		      
	   (propagate (kids button xx yy)
	     (let ((kid (first kids)))
	       (cond
		   ((and kid (mouse-hit kid xx yy))
		       (let ((ret (mouse-down kid
					      button
					      (- xx (offset-x kid))
					      (- yy (offset-y kid)))))
			 (cond
			   (ret (setf (mouse-active container) kid)
				ret)
			   (t   (propagate (rest kids) button xx yy)))))
		   (kid (propagate (rest kids) button xx yy))))))

    (setf (mouse-active container) nil)
    (propagate (put-floating-first (children container)) button xx yy))
  t)

(sheeple:defreply mouse-up ((container =container=) button xx yy)
  "For a CONTAINER getting a mouseup event, it has to see if one of its members accepted the mousedown event.  The container will only accept the mouseup event if a member accepted the mousedown event and that same member accepts the mouseup event."
  (let ((active (mouse-active container)))
    (when active
      (mouse-up active button (- xx (offset-x active))
		              (- yy (offset-y active)))
      (setf (mouse-active container) nil))))

(sheeple:defreply mouse-move ((container =container=) xx yy)
  "For a CONTAINER getting a mouse-move event, it has to see if one of its members accepted the mouse-down event.  The container will only accept the mouse-move event if a member accepted the mouse-down event and that same member accepts the mouse-move event."
  (let ((active (mouse-active container)))
    (when active
      (mouse-move active (- xx (offset-x active))
		         (- yy (offset-y active))))))
