
(asdf:defsystem #:woolly
    :author "Patrick Stein <pat@nklein.com>"
    :maintainer "Patrick Stein <pat@nklein.com>"
    :licence "Public Domain"
    :depends-on (#:sheeple #:zpb-ttf)
    :components ((:module "woolly"
		  :components ((:file "package")
		               (:file "utils"     :depends-on ("package"))
			       (:file "font"      :depends-on ("utils"))
		               (:file "app"       :depends-on ("utils"))
			       (:file "widget"    :depends-on ("font"))
			       (:file "draggable" :depends-on ("widget"))
			       (:file "label"     :depends-on ("widget"))
			       (:file "button"    :depends-on ("widget"))
			       (:file "checkbox"  :depends-on ("button"))
		               (:file "container" :depends-on ("widget"))
			       (:file "subwindow" :depends-on ("container"
			                                       "draggable"))
			       (:file "window"    :depends-on ("container"))))
		 (:module "okolaks"
		  :components ((:static-file "OFL_FAQ.txt")
			       (:static-file "OFL_License.txt")
			       (:static-file "okolaksBold.ttf")
			       (:static-file "okolaksBoldItalic.ttf")
			       (:static-file "okolaksRegular.ttf")))))
