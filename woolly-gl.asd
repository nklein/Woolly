
(asdf:defsystem #:woolly-gl
    :author "Patrick Stein <pat@nklein.com>"
    :maintainer "Patrick Stein <pat@nklein.com>"
    :licence "Public Domain"
    :depends-on (#:woolly #:sheeple #:cl-glut #:cl-glu #:cl-opengl #:cffi)
    :components ((:module "woolly-gl"
		  :components ((:file "package")
			       (:file "gl-woolly"
				:depends-on ("package"))))))
