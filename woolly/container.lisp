
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

(sheeple:defreply mousedown ((container =container=) button xx yy)
  "When a container gets a mousedown message, it has to see if any of its
   children would like to accept the mousedown event.  If they do, it
   has to remember which one so that it can properly route the mouseup
   event later."
  (labels ((propagate (kids button xx yy)
	     (let ((kid (first kids)))
	       (when kid
		 (let ((ret (mousedown kid
				       button
				       (- xx (offset-x kid))
				       (- yy (offset-y kid)))))
		   (cond
		     ((null ret) (propagate (rest kids) button xx yy))
		     (t (setf (mouse-active container) kid)
			ret)))))))
    (setf (mouse-active container) nil)
    (propagate (children container) button xx yy)))

(sheeple:defreply mouseup ((container =container=) button xx yy)
  "For a CONTAINER getting a mouseup event, it has to see if one of its members accepted the mousedown event.  The container will only accept the mouseup event if a member accepted the mousedown event and that same member accepts the mouseup event."
  (let ((active (mouse-active container)))
    (when active
      (mouseup active button (- xx (offset-x active)) (- yy (offset-y active)))
      (setf (mouse-active container) nil))))
