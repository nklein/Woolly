(in-package #:woolly-gl)

(sheeple:defproto =subwindow= (=widget= woolly:=subwindow=)
  ())

(sheeple:defreply sheeple:init-object :after ((ss =subwindow=)
					      &key
					      &allow-other-keys)
  (setf (woolly:dragging ss) nil))

(sheeple:defreply woolly:mouse-down :around ((ss =subwindow=) mb xx yy)
  (let ((ww (woolly:width ss))
	(hh (woolly:height ss)))
    (cond
      ;; in drag bar
      ((and (< -1 xx (- ww 20))
	    (< (- hh 21) yy hh))  (setf (woolly:dragging ss)
					(cons xx yy))
                                  (format t "~S~%" (woolly:dragging ss))
                                  t)

      ;; in iconify region
      ((and (< (- ww 21) xx ww)
	    (< (- hh 21) yy hh))  (setf (woolly:closed ss)
					(not (woolly:closed ss)))
                                  t)

      ;; in main body
      ((and (not (woolly:closed ss))
	    (< -1 xx ww)
	    (< -1 yy (- hh 20)))  (sheeple:call-next-reply)
                                  t)

      ;; missed entirely
      (t nil))))

(sheeple:defreply woolly:mouse-up :before ((ss =subwindow=) mb xx yy)
  (setf (woolly:dragging ss) nil))

(sheeple:defreply woolly:draw ((ss =subwindow=))
  (let ((ww (woolly:width ss))
	(hh (woolly:height ss)))
    (gl:with-pushed-matrix
      (gl:translate 0 (- hh 20) 0)
      (draw-filled-box (- ww 20) 20 '(0.75 0.75 0.75) '(0.5 0.5 0.5))
      (gl:translate (- ww 20) 0 0)
      (draw-filled-box 20 20 '(0.75 0.75 0.5)))

    (unless (woolly:closed ss)
      (draw-filled-box ww (- hh 20) '(0.25 0.25 0.25 0.95) '(0.5 0.5 0.5 0.8))

      (gl:with-pushed-attrib (:transform-bit)
	(gl:enable :clip-plane0)
	(gl:clip-plane :clip-plane0 #(1 0 0 0))
	(gl:enable :clip-plane1)
	(gl:clip-plane :clip-plane1 (vector -1 0 0 ww))
	(gl:enable :clip-plane2)
	(gl:clip-plane :clip-plane2 #(0 1 0 0))
	(gl:enable :clip-plane3)
	(gl:clip-plane :clip-plane3 (vector 0 -1 0 (- hh 20)))
	(mapc #'(lambda (item) (woolly:draw item)) (woolly:children ss))))))
