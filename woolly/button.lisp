
(in-package #:woolly)

(sheeple:defproto =button= (=widget=)
  (label))

(sheeple:defreply sheeple:init-object :after ((button =button=)
					      &key label
					      &allow-other-keys)
  (set? (label button) label))

(sheeple:defmessage clicked (button mouse-button xx yy)
  (:documentation "Indicates that the BUTTON has been clicked with MOUSE-BUTTON being released at coordinates XX YY")
  (:reply (button mouse-button xx yy) (error "Cannot click ~S" button)))

(sheeple:defreply mouse-down ((button =button=) mouse-button xx yy)
  (declare (ignore button mouse-button xx yy))
  (and (< -1 xx (width button))
       (< -1 yy (height button))))

(sheeple:defreply mouse-up ((button =button=) mouse-button xx yy)
  (declare (ignore mouse-button))
  (when (and (< -1 xx (width button))
	     (< -1 yy (height button)))
    (clicked button mouse-button xx yy)
    t))

(sheeple:defreply clicked ((button =button=) mouse-button xx yy)
  (declare (ignore button mouse-button xx yy))
  t)
