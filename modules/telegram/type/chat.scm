(define-module (telegram type chat)
  #:use-modules (oop goops)
  #:use-modules (telegram types chat-photo)
  #:use-modules (telegram types chat-permissions)
  #:export (<chat>
            get-id               set-id!
            get-type             set-type!
            get-title            set-title!
            get-username         set-username!
            get-first-name       set-first-name!
            get-last-name        set-last-name!
            get-chat-photo       set-chat-photo!
            get-description      set-description!
            get-invite-link      set-invite-link!
            get-pinned-message   set-pinned-message!
            get-permissions      set-permissions!
            get-sticker-set-name set-sticker-set-name!
            can-set-sticker-set? set-can-set-sticker-set!))

(define-class <chat> (<telegram-api-type>)
  ;; <number>
  (id #:init-keyword #:id
      #:getter get-id #:setter set-id!)
  ;; <symbol> (private, group, supergroup, channel)
  (type #:init-keyword #:type
        #:getter get-type #:setter set-type!)
  ;; <string>
  (title #:init-keyword #:title
         #:getter get-title #:setter set-title!)
  ;; <string>
  (username #:init-keyword #:username
            #:getter get-username #:setter set-username!)
  ;; <string>
  (first-name #:init-keyword #:first-name
              #:getter get-first-name #:setter set-first-name!)
  ;; <string>
  (last-name #:init-keyword #:last-name
             #:getter get-last-name #:setter set-last-name!)
  ;; <chat-photo>
  (chat-photo #:init-keyword #:chat-photo
              #:getter get-chat-photo #:setter set-chat-photo!)
  ;; <string>
  (description #:init-keyword #:description
               #:getter get-description #:setter set-description!)
  ;; <string>
  (invite-link #:init-keyword #:invite-link
               #:getter get-invite-link #:setter set-invite-link!)
  ;; <message>
  (pinned-message #:init-keyword #:pinned-message
                  #:getter get-pinned-message #:setter set-pinned-message!)
  ;; <chat-permissions>
  (permissions #:init-keyword #:permissions
               #:getter get-permissions #:setter set-permissions!)
  ;; <string>
  (sticket-set-name #:init-keyword #:sticker-set-name
                    #:getter get-sticker-set-name #:setter set-sticker-set-name!)
  ;; <string>
  (can-set-sticker-set? #:init-keyword #:can-set-sticker-set?
               #:getter can-set-sticker-set? #:setter set-can-set-sticker-set!))
