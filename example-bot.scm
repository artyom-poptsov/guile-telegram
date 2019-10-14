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
    (let main-loop ((updates (get-updates bot #:timeout 100)))
      (let loop-over-updates ((lst    updates)
                              (offset 0))
        (if (null? lst)
            (main-loop (get-updates bot #:timeout 100 #:offset offset))
            (let* ((message (get-content (car lst)))
                   (chat    (get-chat message))
                   (chat-id (get-id chat))
                   (sender  (get-from message))
                   (text    (get-text message))
                   (update-id (get-id (car lst))))
              (format #t "sender id: ~a ~%" (get-id sender))
              (format #t "my id: ~a ~%" (get-id me))
              (format #t "update id: ~a~%" update-id)
              (unless (= (get-id me) (get-id sender))
                (display chat-id)
                (newline)
                (display text)
                (newline)
                (send-message bot chat-id (string-append  "_" text "_")  #:parse-mode "Markdown"))
              (sleep 1)
              (loop-over-updates (cdr lst) (if (> update-id offset)
                                               (1+ update-id)
                                               offset))))))))

;;; Local Variables:
;;; mode: Scheme
;;; End:

;;; example-bot.scm ends here.

