;;;; my-web-app.lisp

(in-package #:my-web-app)

;;; "my-web-app" goes here. Hacks and glory await!

(defvar *acceptor*)

(setf (html-mode) :html5)


(defun foo (list))
(define-easy-handler (image :uri "/view") (id)
  (setf (content-type*) "text/html")
  (with-open-file (file (format nil "objects/~a.json" id))
    (let* ((obj (decode-json file))
           (type (cdr (assoc :type obj)))
           (name (cdr (assoc :name obj))))
      (with-html-output-to-string
          (s nil :prologue t :indent 4)
        (:html
         :lang :en
         (:head
          (:meta :charset :utf-8)
          (:meta :name "viewport"
                 :content "width=device-width, initial-scale=1")
          (:title (str name) " | test")
          (:style
           :type "text/css"
           (lass:compile-and-write
            '(html :font-size-adjust 100%)
            '(body :background "#fefefe" :word-wrap break-word))))
         (:body
          (:center (:h1 (str name)))
          (cond 
            ((equal type "image")
             (let ((path (cdr (assoc :path obj))))
               (htm
                "image:"
                (:br)
                (:img :src path))))
            ((equal type "gallery")
             (let ((members (cdr (assoc :members obj))))
               (loop for x in members
                     do
                        (with-open-file (f (conc "objects/" x ".json"))
                          (let*
                              ((obj (decode-json f))
                               (type (cdr (assoc :type obj)))
                               (name (cdr (assoc :name obj)))
                               (id (cdr (assoc :id obj)))
                               (path (cdr (assoc :path obj))))
                            (declare (ignore type))
                            (htm
                             (:p)
                             (:a :href (conc "view?id=" id)
                                 (:img :src path :style "max-height: 100px")
                                 (:br)
                                 (str name))))))))
            (t (htm "not found"))
            )))))))


(defun app ()
  (setf *acceptor* (start (make-instance 'easy-acceptor :port 4242 :document-root #p"./"))))
