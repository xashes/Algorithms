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
;; ll-first - car
;; ll-rest - cdr

;; Linked-List ::= '() | (cons any/c Linked-List)
;; define type
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

;; constructor
(define/contract (construct v llst)
  (-> any/c llist? llist?)
  (node v llst)
  )
(module+ test
  (check-equal? (construct 'a '()) (node 'a '()))
  (check-equal? (construct 'a (construct 'b '()))
                (node 'a (node 'b '())))
  )

;; extractor
(define/contract (ll-first nd)
  (-> node? any/c)
  (node-item nd)
  )
(module+ test
  (check-equal? (ll-first (node 'a '())) 'a)
  )

(define/contract (ll-rest nd)
  (-> node? llist?)
  (node-pointer nd)
  )
(module+ test
  (check-equal? (ll-rest (node 'a '())) '())
  )

;; ll-append: append an item to the end of a llist
;; O(n)
(define/contract (ll-append llst v)
  (-> llist? any/c llist?)
  (if (null? llst)
      (node v '())
      (construct (ll-first llst)
                 (ll-append (ll-rest llst) v)))
  )
(module+ test
  (check-equal? (ll-append '() 'a) (node 'a '()))
  (check-equal? (ll-append (node 'b '()) 'a) (node 'b (node 'a '())))
  (check-equal? (ll-append (node 'a (node 'b '())) 'c)
                (node 'a (node 'b (node 'c '()))))
  )
