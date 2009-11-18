
(asdf:defsystem #:woolly
    :author "Patrick Stein <pat@nklein.com>"
    :maintainer "Patrick Stein <pat@nklein.com>"
    :licence "Public Domain"
    :depends-on (#:sheeple #:zpb-ttf)
    :components ((:module "woolly"
		  :components ((:file "package")
		               (:file "app"
			        :depends-on ("package"))
			       (:file "font"
				:depends-on ("package"))
			       (:file "widget"
				:depends-on ("package"))
		               (:file "container"
			        :depends-on ("package" "widget"))
			       (:file "button"
				:depends-on ("package" "widget"))
			       (:file "window"
				:depends-on ("package" "container"))))))
