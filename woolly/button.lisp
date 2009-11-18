
(in-package #:woolly)

(sheeple:defproto =button= (=widget=)
  (font
   label))

(sheeple:defreply sheeple:init-object :after ((button =button=)
					      &key (font (font button))
					           (label (label button))
					      &allow-other-keys)
  (setf (font button) font
	(label button) label))

(sheeple:defreply mousedown ((button =button=) mouse-button xx yy)
  (declare (ignore button mouse-button xx yy))
  (and (< -1 xx (width button))
       (< -1 yy (height button))))

(sheeple:defreply mouseup ((button =button=) mouse-button xx yy)
  (declare (ignore mouse-button))
  (and (< -1 xx (width button))
       (< -1 yy (height button))))

(sheeple:defreply mouseup :around ((button =button=) mouse-button xx yy)
  (when (sheeple:call-next-reply)
    (format t "~S: Clicked~%" button)
    t))
