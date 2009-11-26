
(in-package #:woolly)

(sheeple:defproto =container= ()
  (children
   mouse-active))

(sheeple:defmessage add (container widget)
  (:documentation "Add the WIDGET to the given CONTAINER"))

(sheeple:defreply add ((container =container=) (widget =widget=))
  (pushnew widget (children container)))

(sheeple:defreply draw ((container =container=))
  (mapc #'(lambda (item) (draw item)) (children container)))

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
    (propagate (children container) button xx yy)))

(sheeple:defreply mouse-up ((container =container=) button xx yy)
  "For a CONTAINER getting a mouseup event, it has to see if one of its members accepted the mousedown event.  The container will only accept the mouseup event if a member accepted the mousedown event and that same member accepts the mouseup event."
  (let ((active (mouse-active container)))
    (when active
      (mouse-up active button (- xx (offset-x active))
		              (- yy (offset-y active)))
      (setf (mouse-active container) nil))))
