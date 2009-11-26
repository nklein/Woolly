(require :asdf)
(asdf:operate 'asdf:load-op 'woolly-gl :verbose nil)

(rename-package 'woolly-gl 'toolkit)

(defun test ()
  (let ((font "okolaks/okolaksRegular.ttf")
	(font-size 20))

    ;; prepare the default font...
    (setf (woolly:font woolly:=widget=) (sheeple:object :parents toolkit:=font=
							:em-size font-size
							:pathname font))

    (let ((app (sheeple:object :parents toolkit:=app=))
	  (win (sheeple:object :parents toolkit:=window=
			       :title "Woolly Window 1"
			       :width 480
			       :height 320))
	  (but (sheeple:object :parents toolkit:=button=
			       :offset-x 10
			       :offset-y 10
			       :width 100
			       :height 40
			       :label "Button")))
      (sheeple:defreply woolly:mouseup :around ((bb but) mouse-button xx yy)
	 (when (sheeple:call-next-reply)
	   (format t "BUTTON CLICKED!~%")
	   t))
	 
      (woolly:display-window win)
      (woolly:add win but)
      (woolly:add win (sheeple:object :parents but
				      :offset-x 120
				      :label "Next Button"))

      (let ((quit-button (sheeple:object :parents but
					 :offset-x 370
					 :label "Quit")))
	(sheeple:defreply woolly:mouseup :around ((bb quit-button) mb xx yy)
	   (when (sheeple:call-next-reply)
	     (woolly:exit-main-loop app)))
	(woolly:add win quit-button))

      (woolly:main-loop app))))
