#!/usr/bin/guile \
-L modules -e main -s
!#

(use-modules (telegram bot)
             (telegram type update)
             (telegram type message)
             (telegram type chat)
             (oop goops)
             (ice-9 pretty-print))


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
                #:proxy (list-ref config 2))))
    (display (get-me bot))
    (while #t
           (let* ((updates (get-updates bot)))
             (if (> (length updates) 0)
                 (let* ((message (raw-data->message (get-content (car updates))))
                        (chat    (get-chat message))
                        (chat-id (get-id chat))
                        (text    (get-text message)))
                   (display chat-id)
                   (newline)
                   (display text)
                   (newline)

                   (send-message bot chat-id (string-append  "_" text "_")  #:parse-mode "Markdown")
                   (sleep 1)))))))

;;; example-bot.scm ends here.
