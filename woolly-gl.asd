
(asdf:defsystem #:woolly-gl
    :author "Patrick Stein <pat@nklein.com>"
    :maintainer "Patrick Stein <pat@nklein.com>"
    :licence "Public Domain"
    :depends-on (#:woolly #:sheeple #:cl-glut #:cl-glu #:cl-opengl #:cffi)
    :components ((:module "woolly-gl"
		  :components ((:file "package")
		               (:file "utils"     :depends-on ("package"))
		               (:file "font"      :depends-on ("package"))
		               (:file "app"       :depends-on ("package"))
		               (:file "widget"    :depends-on ("utils"))
			       (:file "label"	  :depends-on ("font"))
			       (:file "button"	  :depends-on ("widget"
							       "font"))
			       (:file "checkbox"  :depends-on ("button"))
			       (:file "subwindow" :depends-on ("utils" "font"))
			       (:file "window"    :depends-on ("package")))
		  )))
