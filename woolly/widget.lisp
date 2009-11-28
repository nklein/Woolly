
(in-package #:woolly)

(sheeple:defproto =widget= ()
  ((offset-x 0)
   (offset-y 0)
   (width 100)
   (height 100)
   (font :not-a-font)))

(sheeple:defreply sheeple:init-object :after ((ww =widget=)
					      &key offset-x
					           offset-y
					           width
					           height
					           font
					      &allow-other-keys)
  (set? (offset-x ww) offset-x
	(offset-y ww) offset-y
	(width ww) width
	(height ww) height
	(font ww) font))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sheeple:defmessage draw (item)
  (:documentation "Render the ITEM")
  (:reply (item) (error "Do not know how to draw ~S" item)))

(sheeple:defmessage floating (item)
  (:documentation "Returns T if this items should be considered floating above items which do not return T from this message")
  (:reply (item) (error "No way to tell if ~S is floating" item)))

(sheeple:defreply floating ((item =widget=))
  (declare (ignore item))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sheeple:defmessage mouse-down (widget button xx yy)
  (:documentation "Record a mouse-down event for the mouse-button BUTTON at position (XX,YY) within the WIDGET.  The method should return NIL if the widget didn't want the event."))

(sheeple:defmessage mouse-up (widget button xx yy)
  (:documentation "Record a mouse-up event for the mouse-button BUTTON at position (XX,YY) within the WIDGET.  The method should return NIL if the widget didn't want the event."))

(sheeple:defmessage mouse-move (widget xx yy)
  (:documentation "Record a mouse-move event to position (XX,YY) within the WIDGET"))

(sheeple:defreply mouse-down ((widget =widget=) button xx yy)
  (declare (ignore widget button xx yy))
  nil)

(sheeple:defreply mouse-up ((widget =widget=) button xx yy)
  (declare (ignore widget button xx yy))
  nil)

(sheeple:defreply mouse-move ((widget =widget=) xx yy)
  (declare (ignore widget xx yy))
  nil)
