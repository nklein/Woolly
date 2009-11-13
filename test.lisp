(require :asdf)
(asdf:operate 'asdf:load-op 'woolly-gl :verbose nil)

(defun test ()
  (let ((w1 (sheeple:object :parents woolly:=window=
			    :title "Woolly Window 1"))
	(w2 (sheeple:object :parents woolly:=window=
			    :title "Woolly Window 2"
			    :width 320
			    :height 240)))
    (woolly-gl:display-window w1)
    (woolly-gl:display-window w2)
    (woolly-gl:main-loop)
    (woolly-gl:destroy-window w2)
    (woolly-gl:destroy-window w1)))
