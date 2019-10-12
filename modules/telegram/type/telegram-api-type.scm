(define-module (telegram type telegram-api-type)
  #:use-module (oop goops)
  #:export (<telegram-api-type>))

(define-class <telegram-api-type> ()
  (raw-data #:init-keyword #:raw-data
            #:getter get-raw-data #:setter set-raw-data!))
