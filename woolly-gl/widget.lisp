
(in-package #:woolly-gl)

(sheeple:defproto =widget= (woolly:=widget=)
  ())

(sheeple:defreply woolly:draw :around ((ww =widget=))
  (gl:with-pushed-matrix
    (gl:translate (woolly:offset-x ww) (woolly:offset-y ww) 0)
    (gl:with-pushed-attrib (:transform-bit)
      (gl:enable :clip-plane0)
      (gl:clip-plane :clip-plane0 #(1 0 0 0))
      (gl:enable :clip-plane1)
      (gl:clip-plane :clip-plane1 (vector -1 0 0 (woolly:width ww)))
      (gl:enable :clip-plane2)
      (gl:clip-plane :clip-plane2 #(0 1 0 0))
      (gl:enable :clip-plane3)
      (gl:clip-plane :clip-plane3 (vector 0 -1 0 (woolly:height ww)))
      (sheeple:call-next-reply))))

