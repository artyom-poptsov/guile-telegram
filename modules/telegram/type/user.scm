(define-module (telegram type user)
  #:use-module (telegram type telegram-api-type)
  #:use-module (oop goops)
  #:export (<user>
            raw-data->user
            get-id set-id!
            is-bot? set-bot!
            get-first-name set-first-name!
            get-last-name  set-last-name!
            get-username set-username!
            get-language-code set-language-code!)
  #:duplicates (merge-generics))


;; See:
;;   <https://core.telegram.org/bots/api#user>

(define %user-id-field-name            "id")
(define %user-is-bot-field-name        "is_bot")
(define %user-first-name-field-name    "first_name")
(define %user-last-name-field-name     "last_name")
(define %user-username-field-name      "username")
(define %user-language-code-field-name "language_code")

(define-generic get-id)

(define-class <user> (<telegram-api-type>)
  ;; <number>
  (id            #:init-keyword #:id
                 #:getter get-id   #:setter set-id!)
  ;; <boolean>
  (bot?          #:init-keyword #:bot?
                 #:getter bot?  #:setter set-bot!)
  ;; <string>
  (first-name    #:init-keyword #:first-name
                 #:getter get-first-name #:setter set-first-name!)
  ;; <string>
  (last-name     #:init-keyword #:last-name
                 #:getter get-last-name  #:setter set-last-name!)
  ;; <string>
  (username      #:init-keyword #:username
                 #:getter get-username   #:setter set-username!)
  ;; <string>
  (language-code #:init-keyword #:language-code
                 #:getter get-language-code #:setter set-language-code!))


;;;; Hash table accessors.

(define-method (%user:id (data <hashtable>))
  (hash-ref data %user-id-field-name))

(define-method (%user:bot? (data <hashtable>))
  (hash-ref data %user-is-bot-field-name) "true")

(define-method (%user:first-name (data <hashtable>))
  (hash-ref data %user-first-name-field-name))

(define-method (%user:last-name (data <hashtable>))
  (hash-ref data %user-last-name-field-name))

(define-method (%user:username (data <hashtable>))
  (hash-ref data %user-username-field-name))

(define-method (%user:language-code (data <hashtable>))
  (hash-ref data %user-language-code-field-name))



(define-method (raw-data->user (data <hashtable>))
  (make <user>
    #:id            (%user:id data)
    #:bot?          (%user:bot? data)
    #:first-name    (%user:first-name data)
    #:last-name     (%user:last-name data)
    #:username      (%user:username data)
    #:language-code (%user:language-code data)))

;;;; user.scm ends here.

