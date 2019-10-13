#!/usr/bin/env sh
exec guile -L . -L modules -e "(@ (example-bot) main)" -s "$0" "$@"
!#

(define-module (example-bot)
  #:use-module (telegram bot)
  #:use-module (telegram type update)
  #:use-module (telegram type message)
  #:use-module (telegram type chat)
  #:use-module (telegram type user)
  #:use-module (oop goops)
  #:use-module (ice-9 pretty-print)
  #:export (main)
  #:duplicates (merge-generics))



;; Entry point
(define (main args)
  ;; 'config.scm' file format:
  ;;   (<token> <bot-name> <proxy>)
  ;; Example:
  ;;   ("token" "scheme-bot" "socks5://192.168.1.1:9050")
  (let* ((config (read (open-input-file "config.scm")))
         (bot (make <telegram-bot>
                #:token (list-ref config 0)
                #:name  (list-ref config 1)
                #:proxy (list-ref config 2)))
         (me (get-me bot)))
    (while #t
           (let* ((updates (get-updates bot)))
             (if (> (length updates) 0)
                 (let* ((message (raw-data->message (get-content (car updates))))
                        (chat    (get-chat message))
                        (chat-id (get-id chat))
                        (sender  (get-from message))
                        (text    (get-text message)))
                   (format #t "sender id: ~a ~%" (get-id sender))
                   (format #t "my id: ~a ~%" (get-id me))
                   (format #t "message id: ~a" (get-id message))
                   (unless (= (get-id chat) (get-id sender))
                     (display chat-id)
                     (newline)
                     (display text)
                     (newline)
                     (send-message bot chat-id (string-append  "_" text "_")  #:parse-mode "Markdown")))
                   (sleep 1))))))

;;; example-bot.scm ends here.
