(define-module (telegram types chat-permissions)
  #:use-modules (oop goops)
  #:export (<chat-permissions>
            can-send-messages?         set-send-permission!
            can-send-media-messages?   set-send-media-permission!
            can-send-polls?            set-send-polls-permission!
            can-send-other-messages?   set-send-other-permission!
            can-add-web-page-previews? set-web-page-previews-permission!
            can-change-info?           set-change-info-permission!
            can-invite-users?          set-invite-users-permission!
            can-pin-messages?          set-pin-messages-permission!))


(define-class <chat-permissions> (<telegram-api-type>)
  ;; <boolean>
  (can-send-messages?
   #:init-keyword #:can-send-messages?
   #:getter can-send-messages? #:setter set-send-permission!)

  ;; <boolean>
  (can-send-media-messages?
   #:init-keyword #:can-send-media-messages?
   #:getter can-send-media-messages? #:setter set-send-media-permission!)

  ;; <boolean>
  (can-send-polls?
   #:init-keyword #:can-send-polls?
   #:getter can-send-polls? #:setter set-send-polls-permission!)

  ;; <boolean>
  (can-send-other-messages?
   #:init-keyword #:can-send-other-messages?
   #:getter can-send-other-messages? #:setter set-send-other-permission!)

  ;; <boolean>
  (can-add-web-page-previews?
   #:init-keyword #:can-add-web-page-previews?
   #:getter can-add-web-page-previews? #:setter set-web-page-previews-permission!)

  ;; <boolean>
  (can-change-info?
   #:init-keyword #:can-change-info?
   #:getter can-change-info? #:setter set-change-info-permission!)

  ;; <boolean>
  (can-invite-users?
   #:init-keyword #:can-invite-users?
   #:getter can-invite-users? #:setter set-invite-users-permission!)

  ;; <boolean>
  (can-pin-messages?
   #:init-keyword #:can-pin-messages?
   #:getter can-pin-messages? #:setter set-pin-messages-permission!))
