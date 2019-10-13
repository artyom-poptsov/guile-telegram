(define-module (telegram type message)
  #:use-module (oop goops)
  #:use-module (telegram types telegram-api-type)
  #:use-module (telegram types chat-photo)
  #:export (<message>))

(define-class <message> (<telegram-api-type>)
  ;; <number>
  (message-id #:init-keyword #:message-id
              #:getter get-message-id #:setter set-message-id!)
  ;; [optional] <user>
  (from       #:init-keyword #:from
              #:getter get-from       #:setter set-from!)
  ;; <number> (Unix time)
  (date       #:init-keyword #:date
              #:getter get-date       #:setter set-date!)
  ;; <chat>
  (chat       #:init-keyword #:chat
              #:getter get-chat       #:setter set-chat!))

