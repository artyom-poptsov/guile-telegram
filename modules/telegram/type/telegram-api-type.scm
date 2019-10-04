(define-module (telegram types telegram-api-type)
  #:use-modules (oop goops)
  #:export (<telegram-api-type>))

(define-class <telegram-api-type> ()
  (raw-data #:init-keyword #:raw-data
            #:getter get-raw-data #:setter set-raw-data!))
