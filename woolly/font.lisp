
(in-package #:woolly)

(sheeple:defproto =font= ()
  ((em-size 12)
   zpb-font-loader))

(sheeple:defreply init-object ((font =font=) &key (em-size (em-size font))
				             &allow-other-keys)
  (setf (em-size font) em-size))

(sheeple:defmessage open-font (font pathname)
  (:documentation "Force the FONT sheep to open the font specified by PATHNAME")
  (:reply (f p) (error "No way to open a font on (~S,~S)" f p)))

(sheeple:defreply open-font ((font =font=) pathname)
  (setf (zpb-font-loader font) (zpb-ttf:open-font-loader pathname)))

(sheeple:defmessage draw-string (font string &key xx yy centered)
  (:documentation "Tell FONT to render STRING.  The font baseline will begin at (XX,YY) when CENTERED is nil.  The rendered string will be centered at (XX,YY) when CENTERED is not nil.")
  (:reply (f s &key xx yy centered)
	  (declare (ignore xx yy centered))
	  (error "No way to render string (~S) on a ~S" s f)))
