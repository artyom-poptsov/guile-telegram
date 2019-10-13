(define-module (telegram type message)
  #:use-module (oop goops)
  #:use-module (telegram type telegram-api-type)
  #:use-module (telegram type chat-photo)
  #:export (<message>
            raw-data->message
            get-message-id set-message-id!
            get-from set-from!
            get-date set-date!
            get-chat set-chat!
            get-text set-text!))


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
              #:getter get-chat       #:setter set-chat!)
  ;; [optional] <string>
  (text       #:init-keyword #:text
              #:getter get-text       #:setter set-text!))


;; Convert a raw data from Telegram API to an <message> object.
(define-method (raw-data->message (data <hashtable>))
  (make <message>
    #:message-id (hash-ref data "message_id")
    #:from       (hash-ref data "from")
    #:date       (hash-ref data "date")
    #:chat       (hash-ref data "chat")
    #:text       (hash-ref data "text")))

;;;; message.scm ends here.

