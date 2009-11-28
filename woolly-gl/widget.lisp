
(in-package #:woolly-gl)

(sheeple:defproto =widget= (woolly:=widget=)
  ())

(sheeple:defreply woolly:draw :around ((ww =widget=))
  (gl:with-pushed-matrix
    (gl:translate (woolly:offset-x ww) (woolly:offset-y ww) 0)
    (with-clip-to (0 0 (woolly:width ww) (woolly:height ww))
      (sheeple:call-next-reply))))
