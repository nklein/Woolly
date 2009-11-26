(in-package #:woolly)

(sheeple:defproto =app= ()
  ())

(sheeple:defmessage main-loop (a)
  (:documentation "This message begins handling GUI events for the application A")
  (:reply (a) (error "No main-loop for ~A" a)))

(sheeple:defmessage exit-main-loop (a)
  (:documentation "This message stops handling GUI events for the application A")
  (:reply (a) (error "No way to exit main-loop for ~A" a)))
