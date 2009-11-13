(require :asdf)
(asdf:operate 'asdf:load-op 'woolly-gl :verbose nil)

(rename-package 'woolly-gl 'woolly-gl '(toolkit))

(defun test ()
  (let ((app (sheeple:object :parents toolkit:=app=))
	(w1 (sheeple:object :parents toolkit:=window=
			    :title "Woolly Window 1"))
	(w2 (sheeple:object :parents toolkit:=window=
			    :title "Woolly Window 2"
			    :width 320
			    :height 240)))
    (woolly:display-window w1)
    (woolly:display-window w2)
    (woolly:main-loop app)
    (woolly:destroy-window w2)
    (woolly:destroy-window w1)))
