(in-package #:woolly-gl)

(defclass woolly-window-gl (glut:window)
  ()
  (:default-initargs :width 640
                     :height 480
		     :title "Woolly"
		     :mode '(:single :rgb :depth)))

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
    ((eql key #\p) (setf (slot-value w 'paused) (not (slot-value w 'paused))))
    ((eql key #\z) (glut:destroy-current-window))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sheeple:defreply sheeple:init-object :after ((ww woolly:=window=)
					      &key (width (woolly:width ww))
					           (height (woolly:height ww))
					           (title  (woolly:title ww)))
  (let ((gl-window (make-instance 'woolly-window-gl
				  :width  width
				  :height height
				  :title  title
				  :mode   '(:single :rgb))))
    (sheeple:add-property ww 'gl-window gl-window :accessor t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun destroy-window (woolly-window)
  (let ((ww (gl-window woolly-window)))
    (when ww
      (glut:destroy-window (glut:id ww))
      (setf (gl-window woolly-window) nil))))

(defun display-window (woolly-window)
  (let (glut:*run-main-loop-after-display*)
    (let ((ww (gl-window woolly-window)))
      (glut:display-window ww))))

(defun main-loop ()
  (glut:main-loop))
