
(in-package #:woolly)

(sheeple:defproto =widget= ()
  ((offset-x 0)
   (offset-y 0)
   (width 100)
   (height 100)))

(sheeple:defreply sheeple:init-object :after ((ww woolly:=widget=)
					      &key (offset-x (offset-x ww))
					           (offset-y (offset-y ww))
					           (width (width ww))
					           (height (height ww))
					      &allow-other-keys)
  (setf (offset-x ww) offset-x
	(offset-y ww) offset-y
	(width ww) width
	(height ww) height))

(sheeple:defmessage draw (item)
  (:documentation "Render the ITEM"))

(sheeple:defmessage mousedown (widget button xx yy)
  (:documentation "Record a mousedown event for the mouse-button BUTTON at position (XX,YY) within the WIDGET.  The method should return NIL if the widget didn't want the event."))

(sheeple:defmessage mouseup (widget button xx yy)
  (:documentation "Record a mouseup event for the mouse-button BUTTON at position (XX,YY) within the WIDGET.  The method should return NIL if the widget didn't want the event."))

(sheeple:defreply mousedown ((widget =widget=) button xx yy)
  (declare (ignore widget button xx yy))
  nil)

(sheeple:defreply mouseup ((widget =widget=) button xx yy)
  (declare (ignore widget button xx yy))
  nil)
