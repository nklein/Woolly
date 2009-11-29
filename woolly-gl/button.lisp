(in-package #:woolly-gl)

(sheeple:defproto =button= (=widget= woolly:=button=)
  (pressed))

(sheeple:defreply sheeple:init-object :after ((bb =button=)
					      &key
					      &allow-other-keys)
  (setf (pressed bb) nil))

(sheeple:defreply woolly:mouse-down :around ((button =button=) mb xx yy)
  (setf (pressed button) (sheeple:call-next-reply))
  (pressed button))

(sheeple:defreply woolly:mouse-up :before ((button =button=) mb xx yy)
  (setf (pressed button) nil))

(sheeple:defreply woolly:draw ((button =button=))
  (let ((ww (woolly:width button))
	(hh (woolly:height button)))
    (gl:with-pushed-attrib (:current-bit :line-bit :polygon-bit)
      (draw-bevel-box ww hh 5 (not (pressed button))
		      '(0.5 0.5 0.5 1) '(0.75 0.75 0.75 1)))
    (gl:color 0 0 0 1)
    (when (pressed button)
      (gl:translate 1.5 -3 0))
    (with-clip-to (5 5 (- ww 5) (- hh 5))
      (woolly:draw-string (woolly:font button) (woolly:label button)
			  :xx (/ ww 2) :yy (/ hh 2) :centered :both))))
