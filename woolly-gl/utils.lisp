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
  (gl:with-pushed-attrib (:current-bit)
    (gl:with-primitives :quads
      (when color1 (apply #'color color1))
      (gl:vertex 0 0)
      (gl:vertex ww 0)
      (when color2 (apply #'color color2))
      (gl:vertex ww hh)
      (gl:vertex 0 hh))))

(defun draw-bevel-box (ww hh bb up? &optional color1 color2)
  (let ((dx (min bb (/ ww 2)))
	(dy (min bb (/ hh 2)))
	(zz (if up? bb (- bb))))
    (gl:with-pushed-attrib (:current-bit)
      (gl:with-primitives :quads
	;; center
	(when color1 (apply #'color color1))
	(gl:normal 0 0 1)
	(gl:vertex dx dy zz)
	(gl:vertex (- ww dx) dy zz)
	(when color2 (apply #'color color2))
	(gl:vertex (- ww dx) (- hh dy) zz)
	(gl:vertex dx (- hh dy) zz)

	;; top
	(gl:normal 0 zz dy)
	(when color2 (apply #'color color2))
	(gl:vertex dx (- hh dy) zz)
	(gl:vertex (- ww dx) (- hh dy) zz)
	(gl:vertex ww hh 0)
	(gl:vertex 0 hh 0)

	;; bottom
	(gl:normal 0 (- zz) dy)
	(when color1 (apply #'color color1))
	(gl:vertex dx dy zz)
	(gl:vertex (- ww dx) dy zz)
	(gl:vertex ww 0 0)
	(gl:vertex 0 0 0)

	;; left
	(gl:normal (- zz) 0 dx)
	(when color1 (apply #'color color1))
	(gl:vertex 0 0 0)
	(gl:vertex dx dy zz)
	(when color2 (apply #'color color2))
	(gl:vertex dx (- hh dy) zz)
	(gl:vertex 0 hh 0)

	;; right
	(gl:normal zz 0 dx)
	(when color1 (apply #'color color1))
	(gl:vertex ww 0 0)
	(gl:vertex (- ww dx) dy zz)
	(when color2 (apply #'color color2))
	(gl:vertex (- ww dx) (- hh dy) zz)
	(gl:vertex ww hh 0)))))

(defmacro with-clip-to ((x1 y1 x2 y2) &body body)
  `(gl:with-pushed-attrib (:transform-bit)
     (gl:enable :clip-plane0)
     (gl:clip-plane :clip-plane0 (vector 1 0 0 (- ,x1)))
     (gl:enable :clip-plane1)
     (gl:clip-plane :clip-plane1 (vector -1 0 0 ,x2))
     (gl:enable :clip-plane2)
     (gl:clip-plane :clip-plane2 (vector 0 1 0 (- ,y1)))
     (gl:enable :clip-plane3)
     (gl:clip-plane :clip-plane3 (vector 0 -1 0 ,y2))
     ,@body))
