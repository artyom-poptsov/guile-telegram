(define-module (telegram type update)
  #:use-module (oop goops)
  #:use-module (telegram type telegram-api-type)
  #:use-module (telegram type message)
  #:export     (<update>
                get-update-id set-update-id!
                get-content set-content!
                <update/message>
                <update/edited-message>))


;; This object represents an incoming update.
(define-class <update> (<telegram-api-type>)
  ;; <number>
  (update-id
   #:init-keyword #:update-id
   #:getter get-update-id #:setter set-update-id!)
  ;; One of: <message>, <inline-query>, <chosen-inline-result>,
  ;;         <callback-query>, <shipping-query>, <pre-checkout-query>,
  ;;         <poll>
  (content
   #:init-keyword #:content
   #:getter get-content #:setter set-content!))

;; (define-class <update/message> (<telegram-api-type>))

;; (define-class <update/edited-message> (<update/message>))

;; (define-class <update/channel-post> (<update/message>))

;; (define-class <update/edited-channel-post> (<update/message>))

;; (define-class <update/inline-query> (<update>))

;; (define-class <update/chosen-inline-result> (<update>))

;;;; update.scm ends here.
