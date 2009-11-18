(in-package #:woolly-gl)

(sheeple:defproto =button= (woolly:=button=)
  ())

(sheeple:defreply woolly:draw ((button =button=))
  (let ((ww (woolly:width button))
	(hh (woolly:height button)))
    (gl:with-pushed-matrix
      (gl:translate (woolly:offset-x button) (woolly:offset-y button) 0)
      (gl:with-primitives :line-strip
	(gl:vertex 0 0)
	(gl:vertex ww 0)
	(gl:vertex ww hh)
	(gl:vertex 0 hh)
	(gl:vertex 0 0))
      (woolly:draw-string (woolly:font button) (woolly:label button)
			  :xx (/ ww 2) :yy (/ hh 2) :centered t))))
