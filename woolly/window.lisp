
(in-package #:woolly)

(sheeple:defproto =window= (=container=)
  ((title "Woolly")
   (width 640)
   (height 480)))

(sheeple:defmessage display-window (w)
  (:documentation "Makes the window W visible and active")
  (:reply (w) (error "No display-window defined for ~A" w)))

(sheeple:defmessage destroy-window (w)
  (:documentation "Hides the window W and releases all of its resources")
  (:reply (w) (error "No destroy-window defined for ~A" w)))
