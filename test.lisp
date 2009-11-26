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
	  (default-button (sheeple:object :parents toolkit:=button=
					  :offset-x 10
					  :offset-y 10
					  :width 100
					  :height 40)))
	 
      (woolly:display-window win)
      (woolly:add win (sheeple:object :parents default-button
				      :label "Green"))
      (woolly:add win (sheeple:object :parents default-button
				      :offset-x 120
				      :label "Blue"))

      (let ((quit-button (sheeple:object :parents default-button
					 :offset-x 370
					 :label "Quit")))
	(sheeple:defreply woolly:clicked :after ((bb quit-button) mb xx yy)
	   (woolly:exit-main-loop app))
	(woolly:add win quit-button))

      (woolly:main-loop app))))
