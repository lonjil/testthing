;;;; my-web-app.asd

(asdf:defsystem #:my-web-app
  :description "Describe my-web-app here"
  :author "lonjil <lonjil+spam@gmail.com>"
  :license "CC0"
  :depends-on (#:hunchentoot
               #:split-sequence
               #:livesupport
               #:cl-who
               #:cl-json
               #:lass)
  :serial t
  :components ((:file "package")
               (:file "my-web-app")))

