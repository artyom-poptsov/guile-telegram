(define-module (telegram type chat-photo)
  #:use-module (oop goops)
  #:use-module (telegram type telegram-api-type)
  #:export (<chat-photo>
            get-small-file-id set-small-file-id!
            get-big-file-id set-big-file-id!))

(define-class <chat-photo> (<telegram-api-type>)
  ;; <string>
  (small-file-id #:init-keyword #:small-file-id
                 #:getter get-small-file-id #:setter set-small-file-id!)
  ;; <string>
  (big-file-id #:init-keyword #:big-file-id
               #:getter get-big-file-id #:setter set-big-file-id!))
