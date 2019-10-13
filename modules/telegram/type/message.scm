(define-module (telegram type message)
  #:use-module (oop goops)
  #:use-module (telegram type telegram-api-type)
  #:use-module (telegram type chat-photo)
  #:use-module (telegram type chat)
  #:export (<message>
            raw-data->message
            get-message-id set-message-id!
            get-from set-from!
            get-date set-date!
            get-chat set-chat!
            get-text set-text!))


;; See:
;;   <https://core.telegram.org/bots/api#message>
(define %message-id-field-name   "message_id")
(define %message-from-field-name "from")
(define %message-date-field-name "date")
(define %message-chat-field-name "chat")
(define %message-text-field-name "text")


(define-class <message> (<telegram-api-type>)
  ;; <number>
  (id #:init-keyword #:id
      #:getter get-id #:setter set-id!)
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


(define-method (%message:id (data <hashtable>))
  (hash-ref data %message-id-field-name))

(define-method (%message:from (data <hashtable>))
  (hash-ref data %message-from-field-name))

(define-method (%message:date (data <hashtable>))
  (hash-ref data %message-date-field-name))

(define-method (%message:chat (data <hashtable>))
  (hash-ref data %message-chat-field-name))

(define-method (%message:text (data <hashtable>))
  (hash-ref data %message-text-field-name))


;; Convert a raw data from Telegram API to an <message> object.
(define-method (raw-data->message (data <hashtable>))
  (make <message>
    #:message-id (%message:id data)
    #:from       (%message:from data)
    #:date       (%message:date data)
    #:chat       (raw-data->chat (%message:chat data))
    #:text       (%message:text data)))

;;;; message.scm ends here.

