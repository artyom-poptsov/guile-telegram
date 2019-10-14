;;; Guile Telegram API

(define-module (telegram bot)
  #:use-module (telegram type user)
  #:use-module (telegram type update)
  #:use-module (telegram type message)
  #:use-module (ice-9 rdelim)
  #:use-module (ice-9 popen)
  #:use-module (oop goops)
  #:use-module (json)
  #:export (<telegram-bot>
            get-me
            get-updates
            send-message

            response:okay?
            response:result
            message:chat-id
            message:text))


;;; Constants

(define %telegram-api-url "https://api.telegram.org")
(define %curl-opt         "--silent")
;; (define %curl-opt         "-v")

;; 'getUpdates' method parameters
(define %get-updates-offset-param          "offset")
(define %get-updates-limit-param           "limit")
(define %get-updates-timeout-param         "timeout")
(define %get-updates-allowed-updates-param "allowed_updates")


;; The main class
(define-class <telegram-bot> ()
  (token #:init-value #f #:init-keyword #:token #:getter get-token)
  (name  #:init-value #f #:init-keyword #:name  #:getter get-name)
  (proxy #:init-value #f #:init-keyword #:proxy #:getter get-proxy))


;; Send a message MESSAGE to the bot API.
(define-method (api-request (self <telegram-bot>) (method <string>)
                            (parameters <hashtable>))
  (let* ((parstring (if (zero? (hash-count (const #t) parameters))
                        ""
                        (string-append
                         "?"
                         (string-join (hash-fold (lambda (key value prior-result)
                                                  (cons
                                                   (format #f "~a=~a" key value)
                                                   prior-result))
                                                '()
                                                parameters)
                                     "&"))))
         (command (format #f "curl -X GET ~a --proxy ~a '~a/bot~a/~a~a'"
                          %curl-opt
                          (get-proxy self)
                          %telegram-api-url
                          (get-token self)
                          method
                          parstring)))
    (display command)
    (newline)
    (open-input-pipe command)))

(define-method (api-request (self <telegram-bot>) (method <string>))
  (api-request self method (make-hash-table)))


;;; Helper procedures
(define-method (read-all port)
  (let loop ((line  (read-line port))
             (result ""))
    (if (eof-object? line)
        result
        (loop (read-line port) (string-append result line)))))

;;; API Methods.

;; Make a 'getMe' request to the API.
;;
;; This method returns the raw response in the form of a list of hash tables.
(define-method (%get-me (self <telegram-bot>))
  (let ((p (api-request self "getMe")))
    (json-string->scm (read-all p))))

;; Make a 'getMe' request to the API.
(define-method (get-me (self <telegram-bot>))
  (let ((response (%get-me self)))
    (if (response:okay? response)
        (let ((result (response:result response)))
          (raw-data->user result))
        (error "Failed to make 'getMe' request"))))

(define-method (%get-updates (self <telegram-bot>) (parameters <hashtable>))
  (let ((p (api-request self "getUpdates" parameters)))
    (json-string->scm (read-all p))))

(define* (get-updates self #:key offset limit timeout allowed-updates)
  (let ((parameters (make-hash-table)))
    (when offset
      (hash-set! parameters %get-updates-offset-param offset))
    (when limit
      (hash-set! parameters %get-updates-limit-param limit))
    (when timeout
      (hash-set! parameters %get-updates-timeout-param timeout))
    (when allowed-updates
      (hash-set! parameters %get-updates-allowed-updates-param allowed-updates))
    (let ((response (%get-updates self parameters)))
      (if (response:okay? response)
          (let ((result (response:result response)))
            (if (not (null? result))
                (map (lambda (update)
                       (display (hash-ref (hash-ref update "message") "message_id"))
                       (newline)
                       (make <update>
                         #:raw-data  update
                         #:id        (hash-ref update "update_id")
                         #:content   (raw-data->message (hash-ref update "message")))) ; TODO: Handle other types
                     result)
                #f))
          (error "Failed to make 'getUpdates' request")))))

(define (%make-option name value)
  (if value
      (format #f "&~a=~a" name (if (boolean? value)
                                   "true"
                                   value))
      ""))


(define* (send-message self chat-id message
                       #:key parse-mode disable-web-page-preview? disable-notification?
                       reply-to-message-id reply-markup)
  (let ((p (api-request self
                        (string-append (format #f "sendMessage?chat_id=~a&text=~a"
                                               chat-id message)
                                       (%make-option "parse_mode" parse-mode)
                                       (%make-option "disable_web_page_preview" disable-web-page-preview?)
                                       (%make-option "disable_notification"     disable-notification?)
                                       (%make-option "reply_to_message_id"      reply-to-message-id)
                                       (%make-option "reply_markup"             reply-markup)))))
    (json-string->scm (read-all p))))


;;; Response parsers.

(define (response:okay? response)
  (hash-ref response "ok"))

(define (response:result response)
  (hash-ref response "result"))

(define (message:chat-id message)
  (hash-ref (hash-ref message "chat") "id"))

(define (message:text message)
  (hash-ref message "text"))

;;; telegram.scm ends here.

