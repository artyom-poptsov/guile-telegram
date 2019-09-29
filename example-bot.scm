#!/usr/bin/guile \
-L modules -e main -s
!#

(use-modules (telegram)
             (oop goops))


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
    (while #t
      (let ((u (get-updates bot)))
        (let* ((message (hash-ref (car (response:result u)) "message"))
               (chat-id (message:chat-id message))
               (text    (message:text message)))
          (display text)
          (newline)
          (send-message bot chat-id text)
          (sleep 1))))))

;;; example-bot.scm ends here.
