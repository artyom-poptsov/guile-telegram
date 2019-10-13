(define-module (telegram type chat)
  #:use-module (oop goops)
  #:use-module (telegram type telegram-api-type)
  #:use-module (telegram type chat-photo)
  #:use-module (telegram type chat-permissions)
  #:export (<chat>
            raw-data->chat
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


;; See:
;;   <https://core.telegram.org/bots/api#chat>
(define %chat-id-field-name                  "id")
(define %chat-type-field-name                "type")
(define %chat-title-field-name               "title")
(define %chat-username-field-name            "username")
(define %chat-first-name-field-name          "first_name")
(define %chat-last-name-field-name           "last_name")
(define %chat-photo-field-name               "photo")
(define %chat-description-field-name         "description")
(define %chat-invite-link-field-name         "invite_link")
(define %chat-pinned-message-field-name      "pinned_message")
(define %chat-permissions-field-name         "permissions")
(define %chat-sticker-set-name-field-name    "sticker_set_name")
(define %chat-can-set-sticker-set-field-name "can_set_sticker_set")


;; The <chat> class.
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
  (photo #:init-keyword #:photo
         #:getter get-photo #:setter set-photo!)
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
  (sticker-set-name #:init-keyword #:sticker-set-name
                    #:getter get-sticker-set-name #:setter set-sticker-set-name!)
  ;; <string>
  (can-set-sticker-set? #:init-keyword #:can-set-sticker-set?
               #:getter can-set-sticker-set? #:setter set-can-set-sticker-set!))



(define-method (%chat:id (data <hashtable>))
  (hash-ref data %chat-id-field-name))

(define-method (%chat:type (data <hashtable>))
  (hash-ref data %chat-type-field-name))

(define-method (%chat:title (data <hashtable>))
  (hash-ref data %chat-title-field-name))

(define-method (%chat:username (data <hashtable>))
  (hash-ref data %chat-username-field-name))

(define-method (%chat:first-name (data <hashtable>))
  (hash-ref data %chat-first-name-field-name))

(define-method (%chat:last-name (data <hashtable>))
  (hash-ref data %chat-last-name-field-name))

(define-method (%chat:photo (data <hashtable>))
  (hash-ref data %chat-photo-field-name))

(define-method (%chat:description (data <hashtable>))
  (hash-ref data %chat-description-field-name))

(define-method (%chat:invite-link (data <hashtable>))
  (hash-ref data %chat-invite-link-field-name))


(define-method (raw-data->chat (data <hashtable>))
  (make <chat>
    #:id          (%chat:id data)
    #:type        (string->symbol (%chat:type data))
    #:title       (%chat:title data)
    #:username    (%chat:username data)
    #:first-name  (%chat:first-name data)
    #:last-name   (%chat:last-name data)
    #:photo       (%chat:photo data)
    #:description (%chat:description data)
    #:invite-link (%chat:invite-link data)))

;;;; chat.scm ends here.
