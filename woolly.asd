
(asdf:defsystem #:woolly
    :author "Patrick Stein <pat@nklein.com>"
    :maintainer "Patrick Stein <pat@nklein.com>"
    :licence "Public Domain"
    :depends-on (#:sheeple #:zpb-ttf)
    :components ((:module "woolly"
		  :components ((:file "package")
		               (:file "utils"
			        :depends-on ("package"))
			       (:file "font"
				:depends-on ("package" "utils"))
		               (:file "app"
			        :depends-on ("package" "utils"))
			       (:file "widget"
				:depends-on ("package" "utils"
						       "font"))
		               (:file "container"
			        :depends-on ("package" "utils"
						       "widget"))
			       (:file "button"
				:depends-on ("package" "utils"
						       "widget"
						       "font"))
			       (:file "window"
				:depends-on ("package" "utils"
						       "container"))))))
