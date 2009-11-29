(in-package #:woolly-gl)

(sheeple:defproto =label= (=widget= woolly:=label=)
  ())

(sheeple:defreply woolly:draw ((label =label=))
  (let ((ww (woolly:width label))
	(hh (woolly:height label)))
    (gl:color 0 0 0 1)
    (with-clip-to (0 0 ww hh)
      (woolly:draw-string (woolly:font label) (woolly:label label)
			  :xx 0 :yy (/ hh 2) :centered :vertical))))
