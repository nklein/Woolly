
(asdf:defsystem #:woolly-gl
    :author "Patrick Stein <pat@nklein.com>"
    :maintainer "Patrick Stein <pat@nklein.com>"
    :licence "Public Domain"
    :depends-on (#:woolly #:sheeple #:cl-glut #:cl-glu #:cl-opengl #:cffi)
    :components ((:module "woolly-gl"
		  :components ((:file "package")
		               (:file "utils"
			        :depends-on ("package"))
		               (:file "font"
			        :depends-on ("package"))
		               (:file "app"
			        :depends-on ("package"))
		               (:file "widget"
			        :depends-on ("package"))
			       (:file "button"
				:depends-on ("package" "widget" "utils"))
			       (:file "window"
				:depends-on ("package"))))))
