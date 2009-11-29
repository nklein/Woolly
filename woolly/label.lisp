
(in-package #:woolly)

(sheeple:defproto =label= (=widget=)
  (label))

(sheeple:defreply sheeple:init-object :after ((ll =label=)
					      &key label
					      &allow-other-keys)
  (set? (label ll) label))
