(in-package #:woolly-gl)

(sheeple:defproto =checkbox= (=widget= woolly:=checkbox=)
  ())

(sheeple:defreply woolly:draw ((checkbox =checkbox=))
  (let ((ww (woolly:width checkbox))
	(hh (woolly:height checkbox)))
    (gl:with-pushed-attrib (:current-bit :line-bit :polygon-bit)
      (gl:translate 0 (/ hh 4) 0)
      (draw-bevel-box (/ hh 2) (/ hh 2) 5 (not (woolly:pushed checkbox))
		      '(0.5 0.5 0.5 1) '(0.75 0.75 0.75 1))
      (gl:translate 0 (/ hh -4) 0))
    (gl:color 0 0 0 1)
    (woolly:draw-string (woolly:font checkbox) (woolly:label checkbox)
			:xx (* hh 3/4) :yy (/ hh 2) :centered :vertical)))
