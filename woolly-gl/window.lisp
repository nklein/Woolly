(in-package #:woolly-gl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass woolly-window-gl (glut:window)
  ((object :initarg :object
	   :initform (error "Must attach to a woolly-gl:=window=")))
  (:default-initargs :width 640
                     :height 480
		     :title "Woolly"
		     :mode '(:double :rgba :alpha :stencil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sheeple:defproto =window= (woolly:=window=)
  (gl-window))

(sheeple:defreply sheeple:init-object :before ((ww =window=)
					      &key width
					           height
					           title
                                              &allow-other-keys)
  (woolly:set? (woolly:width ww) width
	       (woolly:height ww) height
	       (woolly:title ww) title)
  (setf	(gl-window ww) (make-instance 'woolly-window-gl
				      :object ww
				      :width  width
				      :height height
				      :title  title)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sheeple:defreply woolly:display-window ((woolly-window =window=))
  (let (glut:*run-main-loop-after-display*)
    (let ((ww (gl-window woolly-window)))
      (glut:display-window ww))))

(sheeple:defreply woolly:draw :before ((woolly-window =window=))
  (gl:with-pushed-attrib (:current-bit)
    (let ((ww (woolly:width woolly-window))
	  (hh (woolly:height woolly-window)))
      (gl:with-primitives :quads
	(gl:color 0 0 0.25 1)
	(gl:vertex 0 0)
	(gl:vertex ww 0)
	(gl:color 0 0 0.75 1)
	(gl:vertex ww hh)
	(gl:vertex 0 hh)))))

(sheeple:defreply woolly:destroy-window ((woolly-window =window=))
  (let ((ww (gl-window woolly-window)))
    (when ww
      (glut:destroy-window (glut:id ww))
      (setf (gl-window woolly-window) nil))))

(sheeple:defreply woolly:mouse-down :around ((woolly-window =window=)
					     button xx yy)
  (sheeple:call-next-reply woolly-window
			   button
			   xx
			   (- (woolly:height woolly-window) yy 1)))

(sheeple:defreply woolly:mouse-up :around ((woolly-window =window=)
					   button xx yy)
  (sheeple:call-next-reply woolly-window
			   button
			   xx
			   (- (woolly:height woolly-window) yy 1)))

(sheeple:defreply woolly:mouse-move :around ((woolly-window =window=)
					     xx yy)
  (sheeple:call-next-reply woolly-window
			   xx
			   (- (woolly:height woolly-window) yy 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod glut:display-window :before ((w woolly-window-gl))
  (gl:clear-color 0 0 0 0)
  (gl:stencil-mask 1)
  (gl:clear-stencil 0)
  (gl:stencil-op :invert :invert :invert)
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (gl:matrix-mode :modelview)
  (gl:load-identity)
  (gl:enable :blend)
  (gl:blend-func :src-alpha :one-minus-src-alpha)
  (gl:enable :normalize)
  (gl:enable :rescale-normal)
  (gl:enable :lighting)
  (gl:enable :light0)
  (gl:enable :color-material)
  (gl:shade-model :smooth)
  (gl:light-model :light-model-local-viewer nil)
  (gl:color-material :front-and-back :ambient-and-diffuse)
  (gl:light :light0 :position #(-3 6 9 0))
  (gl:light :light0 :ambient #(0.0 0.0 0.0 1.0))
  (gl:light :light0 :diffuse #(0.85 0.85 0.8 1.0))
  (gl:light :light0 :specular #(1 1 0.9 1)))

(defmethod glut:display ((w woolly-window-gl))
  (gl:clear :color-buffer-bit)
  (with-slots (object) w
    (woolly:draw object))
  (gl:flush)
  (glut:swap-buffers))

(defmethod glut:reshape ((w woolly-window-gl) width height)
  (gl:viewport 0 0 width height)
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (with-slots (object) w
    (let ((target-width (woolly:width object))
	  (target-height (woolly:height object)))
      (cond
	((or (zerop target-width) (zerop target-height))
	   (format t "Bad width and height!"))
	((< (* width target-height) (* height target-width))
	   (let ((y-offset (/ (- target-height (* target-width
						  (/ height width)))
			      2)))
	     (gl:ortho 0 target-width
		       y-offset (- target-height y-offset)
		       -100 100)))
	(t  (let ((x-offset (/ (- target-width (* target-height
						  (/ width height)))
			       2)))
	      (gl:ortho x-offset (- target-width x-offset)
			0 target-height
			-100 100))))))
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
    ((eql key #\p) (describe w))
    ((eql key #\z) (woolly:destroy-window (slot-value w 'object)))))

(defmethod glut:mouse ((w woolly-window-gl) button state xx yy)
  (multiple-value-bind (xx yy zz) (glu:un-project xx yy 0)
    (declare (ignore zz))
    (with-slots (object) w
      (cond
	((eq state :down) (woolly:mouse-down object button xx yy))
	((eq state :up)   (woolly:mouse-up object button xx yy))))
    (glut:post-redisplay)))

(defmethod glut:motion ((w woolly-window-gl) xx yy)
  (multiple-value-bind (xx yy zz) (glu:un-project xx yy 0)
    (declare (ignore zz))
    (with-slots (object) w
      (when (woolly:mouse-move object xx yy)
	(glut:post-redisplay)))))
