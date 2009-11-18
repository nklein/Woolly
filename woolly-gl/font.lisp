(in-package #:woolly-gl)

(sheeple:defproto =font= (woolly:=font=)
  ())

(sheeple:defmessage woolly:draw-string ((font =font=) (string sheeple:=string)
					&key (xx 0) (yy 0) centered)
  (labels ((render-glyph (glyph)
	     (gl:with-primitives :polygon
	       (zpb-ttf:do-contours (contour glyph)
		 (zpb-ttf:do-contour-segments (start ctrl end) contour
		    (gl:vertex (zpb-ttf:x start) (zpb-ttf:y start))))))

	   (render-string (string font-loader &optional (pos 0) prev)
	     (when (< pos (length string))
	       (let ((cur (zpb-ttf:find-glyph (aref string pos) font-loader)))
		 (render-glyph cur)
		 (gl:translate 0 (zpb-ttf:advance-width cur))
		 (when prev
		   (gl:translate 0 (zpb-ttf:kerning-offset prev
							   cur
							   font-loader))))
	       (render-string string font-loader (1+ pos) cur))))
    (let ((font-loader (woolly:zpb-font-loader font)))
      (gl:with-pushed-matrix
	  (when centered
	    (let ((bounds (zpb-ttf:string-bounding-box string
						       font-loader
						       :kerning t)))
	      (gl:translate (/ (- (aref bounds 2) (aref bounds 0)) 2)
			    (/ (- (aref bounds 3) (aref bounds 1)) 2))))
	(render-string string font-loader)))))

