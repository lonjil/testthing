;;;; my-web-app.asd

(asdf:defsystem #:my-web-app
  :description "Describe my-web-app here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:hunchentoot
			   #:split-sequence
			   #:livesupport
			   #:cl-who
			   #:cl-json
			   #:lass)
  :serial t
  :components ((:file "package")
               (:file "my-web-app")))

