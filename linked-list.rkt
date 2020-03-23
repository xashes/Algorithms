#lang racket

(module+ test
  (require rackunit rackunit/text-ui)
  )

(provide (contract-out [struct node
                         ([item any/c]
                          [pointer llist?])]
                       ))

;; API
;; construct - cons
;; item - car
;; pointer - cdr

;; Linked-List ::= '() | (cons any/c Linked-List)
(struct node (item pointer) #:transparent)
(define/contract (llist? v)
  (-> any/c boolean?)
  (or (null? v)
      (node? v))
  )
(module+ test
  (check-true (llist? '()))
  (check-true (llist? (node 'a '())))
  )
