(in-package #:woolly-gl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-condition exit-main-loop-condition (condition)
  ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass woolly-window-gl (glut:window)
  ((object :initarg :object
	   :initform (error "Must attach to a woolly-gl:=window=")))
  (:default-initargs :width 640
                     :height 480
		     :title "Woolly"
		     :mode '(:single :rgb :depth)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sheeple:defproto =window= (woolly:=window=)
  (gl-window))

(sheeple:defreply sheeple:init-object :after ((ww woolly-gl:=window=)
					      &key (width (woolly:width ww))
					           (height (woolly:height ww))
					           (title  (woolly:title ww)))
  (setf (gl-window ww) (make-instance 'woolly-window-gl
				      :object ww
				      :width  width
				      :height height
				      :title  title
				      :mode   '(:single :rgb))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sheeple:defreply woolly:display-window ((woolly-window =window=))
  (let (glut:*run-main-loop-after-display*)
    (let ((ww (gl-window woolly-window)))
      (glut:display-window ww))))

(sheeple:defreply woolly:destroy-window ((woolly-window =window=))
  (let ((ww (gl-window woolly-window)))
    (when ww
      (glut:destroy-window (glut:id ww))
      (setf (gl-window woolly-window) nil))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod glut:display-window :before ((w woolly-window-gl))
  (gl:clear-color 0 0 0 0)
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (gl:matrix-mode :modelview)
  (gl:load-identity))

(defmethod glut:display ((w woolly-window-gl))
  )

(defmethod glut:reshape ((w woolly-window-gl) width height)
  (gl:viewport 0 0 width height)
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (gl:ortho -1 1 -1 1 1.5 500)
  (gl:matrix-mode :modelview)
  (gl:load-identity))

#|
(defmethod glut:visibility ((w woolly-window-gl) state)
  (case state
    (:visible (glut:enable-event w :idle))
    (t        (glut:disable-event w :idle))))
|#


(defmethod glut:keyboard ((w woolly-window-gl) key xx yy)
  (declare (ignore xx yy))
  (cond
    ((eql key #\q) (error 'exit-main-loop-condition))
    ((eql key #\p) (describe w))
    ((eql key #\z) (woolly:destroy-window (slot-value w 'object)))))

