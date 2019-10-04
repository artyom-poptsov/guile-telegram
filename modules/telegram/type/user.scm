(define-module (telegram types user)
  #:use-module (oop goops)
  #:export (<user>
            get-id set-id!
            is-bot? set-bot!
            get-first-name set-first-name!
            get-last-name  set-last-name!
            get-username set-username!
            get-language-code set-language-code!))

(define-class <user> (<telegram-api-type>)
  ;; Number
  (id            #:init-keyword #:id
                 #:getter get-id   #:setter set-id!)
  ;; Boolean
  (bot?          #:init-keyword #:is-bot?
                 #:getter is-bot?  #:setter set-bot!)
  ;; String
  (first-name    #:init-keyword #:first-name
                 #:getter get-first-name #:setter set-first-name!)
  ;; String
  (last-name     #:init-keyword #:last-name
                 #:getter get-last-name  #:setter set-last-name!)
  ;; String
  (username      #:init-keyword #:username
                 #:getter get-username   #:setter set-username!)
  ;; String
  (language-code #:init-keyword #:language-code
                 #:getter get-language-code #:setter set-language-code!))


