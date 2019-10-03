(define-module (telegram types user)
  #:use-module (oop goops)
  #:export (<user>
            get-id set-id!
            is-bot? set-bot!
            get-first-name set-first-name!
            get-last-name  set-last-name!
            get-username set-username!
            get-language-code set-language-code!))

(define-class <user> ()
  (id            #:init-keyword #:id
                 #:getter get-id   #:setter set-id!)
  (bot?          #:init-keyword #:is-bot
                 #:getter is-bot?  #:setter set-bot!)
  (first-name    #:init-keyword #:first-name
                 #:getter get-first-name #:setter set-first-name!)
  (last-name     #:init-keyword #:last-name
                 #:getter get-last-name  #:setter set-last-name!)
  (username      #:init-keyword #:username
                 #:getter get-username   #:setter set-username!)
  (language-code #:init-keyword #:language-code
                 #:getter get-language-code #:setter set-language-code!))


