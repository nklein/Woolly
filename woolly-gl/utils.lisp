(in-package #:woolly-gl)

(defun draw-box (ww hh)
  (gl:with-pushed-attrib (:polygon-bit)
    (gl:polygon-mode :front-and-back :line)
    (gl:with-primitives :quads
      (gl:vertex 0 0)
      (gl:vertex ww 0)
      (gl:vertex ww hh)
      (gl:vertex 0 hh))))
