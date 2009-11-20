(in-package #:woolly-gl)

(sheeple:defproto =button= (woolly:=button=)
  (pressed))

(sheeple:defreply woolly:mousedown :around ((button =button=) mb xx yy)
  (setf (pressed button) (sheeple:call-next-reply)))

(sheeple:defreply woolly:mouseup :around ((button =button=) mb xx yy)
  (setf (pressed button) nil)
  (sheeple:call-next-reply))

(sheeple:defreply woolly:draw ((button =button=))
  (labels ((draw-button-shape (ww hh zz &optional color1 color2)
	     (let ((dx (min 5 (/ ww 2)))
		   (dy (min 5 (/ hh 2))))
	       (gl:with-primitives :quads
		 ;; center
		 (when color1 (apply #'gl:color color1))
		 (gl:normal 0 0 1)
		 (gl:vertex dx dy zz)
		 (gl:vertex (- ww dx) dy zz)
		 (when color2 (apply #'gl:color color2))
		 (gl:vertex (- ww dx) (- hh dy) zz)
		 (gl:vertex dx (- hh dy) zz)

		 ;; top
		 (gl:normal 0 zz dy)
		 (when color2 (apply #'gl:color color2))
		 (gl:vertex dx (- hh dy) zz)
		 (gl:vertex (- ww dx) (- hh dy) zz)
		 (gl:vertex ww hh 0)
		 (gl:vertex 0 hh 0)

		 ;; bottom
		 (gl:normal 0 (- zz) dy)
		 (when color1 (apply #'gl:color color1))
		 (gl:vertex dx dy zz)
		 (gl:vertex (- ww dx) dy zz)
		 (gl:vertex ww 0 0)
		 (gl:vertex 0 0 0)

		 ;; left
		 (gl:normal (- zz) 0 dx)
		 (when color1 (apply #'gl:color color1))
		 (gl:vertex 0 0 0)
		 (gl:vertex dx dy zz)
		 (when color2 (apply #'gl:color color2))
		 (gl:vertex dx (- hh dy) zz)
		 (gl:vertex 0 hh 0)

		 ;; right
		 (gl:normal zz 0 dx)
		 (when color1 (apply #'gl:color color1))
		 (gl:vertex ww 0 0)
		 (gl:vertex (- ww dx) dy zz)
		 (when color2 (apply #'gl:color color2))
		 (gl:vertex (- ww dx) (- hh dy) zz)
		 (gl:vertex ww hh 0))))

	   (draw-button (ww hh zz)
	     (draw-button-shape ww hh zz
				'(0.5 0.5 0.5 1) '(0.75 0.75 0.75 1))
	     (gl:with-pushed-matrix
	       (gl:translate 5 5 0)
	       (gl:line-width 1)
	       (gl:color 1 1 1 0.2)
	       (draw-box (- ww 10) (- hh 10)))))

    (let ((ww (woolly:width button))
	  (hh (woolly:height button)))
      (gl:with-pushed-matrix
	  (gl:translate (woolly:offset-x button) (woolly:offset-y button) 0)
	(gl:with-pushed-attrib (:current-bit :line-bit :polygon-bit)
	  (draw-button ww hh (if (pressed button) -5 5)))
	(gl:color 0 0 0 1)
	(when (pressed button)
	  (gl:translate 1.5 -3 0))
	(woolly:draw-string (woolly:font button) (woolly:label button)
			    :xx (/ ww 2) :yy (/ hh 2) :centered t)))))
