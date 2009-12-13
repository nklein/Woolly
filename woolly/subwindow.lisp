
(in-package #:woolly)

(sheeple:defproto =subwindow= (=draggable= =widget=)
  ((title "Little Woolly")
   closed
   container))

(sheeple:defreply sheeple:init-object :after ((ss =subwindow=)
					      &key title
					           closed
					      &allow-other-keys)
  (set? (title ss) title
        (closed ss) closed)
  (setf	(container ss) (sheeple:object :parents =container=)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(sheeple:defreply add ((ss =subwindow=) (widget =widget=))
  (add (container ss) widget))

(sheeple:defreply children ((ss =subwindow=))
  (children (container ss)))
