(require :asdf)
(asdf:operate 'asdf:load-op 'woolly-gl :verbose nil)

(rename-package 'woolly-gl 'toolkit)

(defun test ()
  (let ((font (sheeple:object :parents toolkit:=font=
			      :em-size 48
			      :pathname "okolaks/okolaksRegular.ttf")))
    (let ((app (sheeple:object :parents toolkit:=app=))
	  (win (sheeple:object :parents toolkit:=window=
			       :title "Woolly Window 1"
			       :width 640
			       :height 480))
	  (but (sheeple:object :parents toolkit:=button=
			       :offset-x 40
			       :offset-y 40
			       :width 300
			       :height 100
			       :font font
			       :label "Button")))
      (woolly:display-window win)
      (woolly:add win but)
      (woolly:main-loop app)
      (woolly:destroy-window win))))
