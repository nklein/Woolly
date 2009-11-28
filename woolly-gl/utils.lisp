(in-package #:woolly-gl)

(defun color (r g b &optional (a 1.0))
  (gl:color r g b a))

(defun draw-box (ww hh)
  (gl:with-pushed-attrib (:polygon-bit)
    (gl:polygon-mode :front-and-back :line)
    (gl:with-primitives :quads
      (gl:vertex 0 0)
      (gl:vertex ww 0)
      (gl:vertex ww hh)
      (gl:vertex 0 hh))))

(defun draw-filled-box (ww hh &optional color1 color2)
  (gl:with-primitives :quads
    (when color1 (apply #'color color1))
    (gl:vertex 0 0)
    (gl:vertex ww 0)
    (when color2 (apply #'color color2))
    (gl:vertex ww hh)
    (gl:vertex 0 hh)))
