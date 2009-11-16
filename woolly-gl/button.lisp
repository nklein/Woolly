(in-package #:woolly-gl)

(sheeple:defproto =button= (woolly:=button=)
  ())

(sheeple:defreply woolly:draw ((button =button=))
  (let ((ww (woolly:width button))
	(hh (woolly:height button)))
    (gl:with-primitives :lines
      (gl:vertex 0 0)
      (gl:vertex ww hh)
      (gl:vertex 0 hh)
      (gl:vertex ww 0))))
