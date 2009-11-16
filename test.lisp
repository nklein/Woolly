(require :asdf)
(asdf:operate 'asdf:load-op 'woolly-gl :verbose nil)

(rename-package 'woolly-gl 'woolly-gl '(toolkit))

(defun test ()
  (let ((app (sheeple:object :parents toolkit:=app=))
	(win (sheeple:object :parents toolkit:=window=
			     :title "Woolly Window 1"
			     :width 320
			     :height 240))
	(but (sheeple:object :parents toolkit:=button=
			     :offset-x 0
			     :offset-y 0
			     :width 100
			     :height 100)))
    (woolly:display-window win)
    (woolly:add win but)
    (woolly:main-loop app)
    (woolly:destroy-window win)))
